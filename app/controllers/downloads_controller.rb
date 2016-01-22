class DownloadsController < ApplicationController
  include Sufia::DownloadsControllerBehavior
  
  def authorize_download!
    #authorize! :download, file
  end
  def send_file_contents
        self.status = 200
        prepare_file_headers
        stream_body file.stream
  end    
  def show
    if file.instance_of? ZipFile
      return send_content
    end
    if file.new_record?
      render_404
    else
      send_content
    end
  end
  def stream_body(iostream)
    iostream.each do |in_buff|
      response.stream.write in_buff
    end
  ensure
    response.stream.close
  end
  def send_content
      response.headers['Accept-Ranges'] = 'bytes'

      if request.head?
        content_head
      elsif request.headers['HTTP_RANGE']
        send_range
      else
        print request.headers
        send_file_contents
        
      end
   end  
  def load_file
    file_path = params[:file]
    file = GenericFile.find(params[:id]);
    f = nil
    #if file.instance_of? GenericFile and not file.resource_type.include? 'DataFile'
    #  file = file.data_files.first
    #end
    
    if !file_path && params[:datastream_id]
      Deprecation.warn(DownloadBehavior, "Parameter `datastream_id` is deprecated and will be removed in hydra-head 10.0. Use `file` instead.")
      file_path = params[:datastream_id]
    end
    if file.instance_of? DataFile
      return super
      #f = asset.attached_files[file_path] if file_path
      #f ||= default_file 
    end
    
    if file.instance_of? GenericFile
        f = ZipFile.new(file.id << ".zip")
        #Zip::OutputStream.open(f) { | z | } 
        Zip::File.open(f.path, Zip::File::CREATE) do | zip |
          file.data_files.each do | data_file_obj |
            data_file = fetch_file data_file_obj.id
            zip.get_output_stream(data_file_obj.filename.first) do |zf| 
              data_file.stream.each do | buff |
                zf.print buff
              end 
              zf.close
            end
          end
        end
        
     end 
    
    raise "Unable to find a file for #{params[:id]}" if f.nil?
    f
  end
  def fetch_file(id) 
    dfile = ActiveFedora::Base.find(id)
    if dfile.class.respond_to?(:default_file_path)
      dfile.attached_files[asset.class.default_file_path]
    elsif dfile.class.respond_to?(:default_content_ds)
      Deprecation.warn(DownloadBehavior, "default_content_ds is deprecated and will be removed in hydra-head 10.0, use default_file_path instead")
      dfile.attached_files[asset.class.default_content_ds]
    elsif dfile.attached_files.key?(DownloadsController.default_file_path)
      dfile.attached_files[DownloadsController.default_file_path]
    elsif asset.attached_files.key?(DownloadsController.default_content_dsid)
      Deprecation.warn(DownloadBehavior, "DownloadsController.default_content_dsid is deprecated and will be removed in hydra-head 10.0, use default_file_path instead")
      dfile.attached_files[DownloadsController.default_content_dsid]
    end
  end
  def file_name
        params[:filename] || (file.respond_to?(:name) && file.name) || (asset.respond_to?(:label) && asset.label) || file.id
  end
end


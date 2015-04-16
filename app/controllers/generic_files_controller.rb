class GenericFilesController < ApplicationController
  include Sufia::Controller
  include Sufia::FilesControllerBehavior
   
  self.presenter_class = KarkinosGenericFilePresenter
  @@datafile_edit_form_class = KarkinosDatafileEditForm
  self.edit_form_class = KarkinosFileEditForm
  
  def self.datafile_presenter_class
    @@datafile_presenter_class
  end
  
  # overwrites parent update; routed to /files/:id (PUT)
  def update
    success = if wants_to_revert?
      update_version
    elsif wants_to_add_file?
      add_file
    elsif params.has_key? :generic_file
      update_metadata
    elsif params.has_key? :data_file
      update_datafile_metadata
    elsif params.has_key? :visibility
      update_visibility
    end

    if success
      redirect_to sufia.edit_generic_file_path(tab: params[:redirect_tab]), notice:
        render_to_string(partial: 'generic_files/asset_updated_flash', locals: { generic_file: @generic_file })
    else
      flash[:error] ||= 'Update was unsuccessful.'
      set_variables_for_edit_form
      render action: 'edit'
    end
  end
  
  def add_file
    if params[:filedata]
      file = params[:filedata]
      
      create_datafile_from_upload file
      set_metadata_for_datafile
    
      if !datafile_actor.create_content(file, file.original_filename, file_path, file.content_type)
        msg = @datafile.errors.full_messages.join(', ')
        flash[:error] = msg
        false
      end
    else
      flash[:error] = 'Please select a file.'
      false
    end
    true
  end
  
  def update_metadata
    # set all unused attribute to empty 
    #types_fields_map = AttributeHelper::build_type_symbol_map
    uses_fields_map = AttributeHelper::build_use_symbol_list
    
    fields = []
    #types_fields_map.merge(uses_fields_map).each do |key, array|
    uses_fields_map.each do |key, array|
      array.each do |entry| 
       fields << entry.to_s
      end
    end
    
    file_attributes = edit_form_class.model_attributes(params[:generic_file])
    file_attributes.keys.each do |attr_name|
      fields.delete(attr_name)
    end
    
    # now we have all unsed fields and can set them to empty
    fields.each do |field|
      file_attributes.store(field, presenter_class.multiple?(field.to_sym) ? [] : "")
    end
    
    actor.update_metadata(file_attributes, params[:visibility])
  end
  
  def update_datafile_metadata
    file_attributes = @@datafile_edit_form_class.model_attributes(params[:data_file])
    datafile_actor.update_metadata(file_attributes, params[:visibility])
  end
  
  def datafile_actor
    @datafile_actor ||=  Sufia::GenericFile::Actor.new((@datafile.nil? ? @generic_file : @datafile), current_user)
  end
  
  def process_file(file)
    Batch.find_or_create(params[:batch_id])

    update_metadata_from_upload_screen file
    actor.create_metadata(params[:batch_id])
    
    datafile_actor.create_metadata(params[:batch_id])
    if datafile_actor.create_content(file, file.original_filename, file_path, file.content_type)
      respond_to do |format|
        format.html {
          render 'jq_upload', formats: 'json', content_type: 'text/html'
        }
        format.json {
          render 'jq_upload'
        }
      end
    else
      msg = @datafile.errors.full_messages.join(', ')
      flash[:error] = msg
      json_error "Error creating generic file: #{msg}"
    end
  end
  
  # this is provided so that implementing application can override this behavior and map params to different attributes
  # called when creating or updating metadata
  def update_metadata_from_upload_screen(file)
    # Relative path is set by the jquery uploader when uploading a directory
    @generic_file.relative_path = params[:relative_path] if params[:relative_path]
    @generic_file.on_behalf_of = params[:on_behalf_of] if params[:on_behalf_of]
    @generic_file.label ||= file.original_filename
    @generic_file.title = [@generic_file.label] if @generic_file.title.blank?
    
    create_datafile_from_upload file
  end
  
  def create_datafile_from_upload(file)
    @datafile = DataFile.new
    @datafile.generic_file = @generic_file
    @datafile.filename = [file.original_filename]
  end
  
  def set_metadata_for_datafile
    @datafile.apply_depositor_metadata(current_user)
    time_in_utc = DateTime.now.new_offset(0)
    @datafile.date_uploaded = time_in_utc
    @datafile.date_modified = time_in_utc
    @datafile.creator = [current_user.name]
    @datafile.resource_type = @generic_file.resource_type
    @datafile.rights = @generic_file.rights
  end
  
  def audit_service
    Karkinos::KarkinosFileAuditService.new(@generic_file)
  end
  
  def wants_to_add_file?
    has_file_data = params.has_key?(:filedata)
    has_file_data
  end
  
  def edit_form
    return @@datafile_edit_form_class.new(@generic_file) if @generic_file.instance_of? DataFile
    edit_form_class.new(@generic_file)
  end
   
end
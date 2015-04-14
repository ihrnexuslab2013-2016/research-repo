class GenericFilesController < ApplicationController
  include Sufia::Controller
  include Sufia::FilesControllerBehavior
   
  self.presenter_class = KarkinosGenericFilePresenter
  self.edit_form_class = KarkinosFileEditForm
  
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
  
  def datafile_actor
    @datafile = DataFile.new
    @datafile.generic_file = @generic_file
    @datafile_actor ||=  Sufia::GenericFile::Actor.new(@datafile, current_user)
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
    
  end
   
end
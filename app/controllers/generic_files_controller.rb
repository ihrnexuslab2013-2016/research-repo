class GenericFilesController < ApplicationController
  include Sufia::Controller
  include Sufia::FilesControllerBehavior
   
  self.presenter_class = KarkinosGenericFilePresenter
  self.edit_form_class = KarkinosFileEditForm
  
  def update_metadata
    # set all unused attribute to empty 
    types_fields_map = AttributeHelper::build_type_symbol_map
    uses_fields_map = AttributeHelper::build_use_symbol_list
    
    fields = []
    types_fields_map.merge(uses_fields_map).each do |key, array|
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
   
end
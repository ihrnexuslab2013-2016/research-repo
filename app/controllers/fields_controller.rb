class FieldsController < ApplicationController
  include AttributeHelper
  
  extend ActiveSupport::Concern

  class_attribute :edit_form_class, :presenter_class
  self.presenter_class = KarkinosGenericFilePresenter
  self.edit_form_class = KarkinosFileEditForm
  
  def update_use
    uses = params[:uses].split ','
    
    @generic_file = GenericFile.find(params[:id])
     
    @edit_form = edit_form_class.new(@generic_file)
    @edit_form.uses=uses
    @presenter = @edit_form 
    @form = @edit_form
     
    respond_to do |format|
       format.js {render 'generic_files/update_use.js.erb' }
    end
  end
  
  def update_edit
     resource_types = params[:resource_types].split ','
     
     @generic_file = GenericFile.find(params[:id])
     
     @edit_form = edit_form_class.new(@generic_file)
     @edit_form.resource_types(resource_types)
     @presenter = @edit_form 
     @form = @edit_form
     
     
     respond_to do |format|
        format.js {render 'generic_files/update_edit.js.erb' }
    end
   end
  
end
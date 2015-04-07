class GenericFilesController < ApplicationController
  include Sufia::Controller
  include Sufia::FilesControllerBehavior
  
  
  self.presenter_class = KarkinosGenericFilePresenter
  self.edit_form_class = KarkinosFileEditForm
  
   
    
   
end
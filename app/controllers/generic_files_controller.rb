class GenericFilesController < ApplicationController
  include Sufia::Controller
  include Sufia::FilesControllerBehavior
  
  self.presenter_class = KarkinosGenericFilePresenter
end
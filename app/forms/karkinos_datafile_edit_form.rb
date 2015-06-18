class KarkinosDatafileEditForm < DatafilePresenter 
  include HydraEditor::Form
  include HydraEditor::Form::Permissions
  include AttributeHelper
  
  self.required_fields = [:rights]
  
end
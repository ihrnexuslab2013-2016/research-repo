class KarkinosFileEditForm < KarkinosGenericFilePresenter
  include HydraEditor::Form
  include HydraEditor::Form::Permissions
  include AttributeHelper
  include NestedTitlePrincipals
  
  self.required_fields = [:title, :creator, :tag, :rights]  

end
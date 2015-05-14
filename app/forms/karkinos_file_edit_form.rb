class KarkinosFileEditForm < KarkinosGenericFilePresenter
  include HydraEditor::Form
  include HydraEditor::Form::Permissions
  include AttributeHelper
  include NestedTitlePrincipals
  include NestedTitleUniforms
  include NestedSubjectTopics
  include NestedSubjectGeographics
  
  self.required_fields = [:title, :creator, :tag, :rights]  

end
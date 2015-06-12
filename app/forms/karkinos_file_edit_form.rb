class KarkinosFileEditForm < KarkinosGenericFilePresenter
  include HydraEditor::Form
  include HydraEditor::Form::Permissions
  include AttributeHelper
  include NestedTitlePrincipals
  include NestedTitleUniforms
  include NestedSubjectTopics
  include NestedSubjectGeographics
  include NestedGenres
  include NestedLocationOfResources
  include NestedNamePrincipals
  include NestedNames
  include NestedNoteGroups
  include NestedParts
  include NestedSubjectTemporals
  include NestedSubjectTitles
  include NestedSubjectGeographicCodes
  include NestedSubjectHierarchicalGeographics
  include NestedCartographics
  include NestedSubjectOccupations
  include NestedSubjectGenres
  include NestedRelatedHosts
  include NestedRelatedReferencedBy
  include NestedRelatedOriginals
  include NestedRelatedFormats
  include NestedRelatedVersions
  include NestedRelatedPrecedings
  include NestedRelatedReferences
  include NestedRelatedReviews
  include NestedRelatedSeries
  include NestedRelatedSucceedings
  
  self.required_fields = [:title, :creator, :tag, :rights]  

end
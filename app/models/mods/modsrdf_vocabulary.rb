module MODS
  class MODSRDFVocabulary < RDF::Vocabulary("http://www.loc.gov/mods/modsrdf/v1#")
    
    MODS_NS = "http://www.loc.gov/mods/modsrdf/v1#"
    RDFS_NS = "http://www.w3.org/2000/01/rdf-schema#"
    MADSRDF_NS = "http://www.loc.gov/mads/rdf/v1#"
    RDF_NS = "http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   
    # title   
    property :titlePrincipal
    property :titleUniform
    property :hasAbbreviatedVariant
    property :hasTranslatedVariant  
    property :hasAlternativeVariant
    
    property :abstract
    property :accessCondition
    property :genre
    property :languageOfResource
    property :locationOfResource
    property :locationPhysicalLocation
    property :locationShelfLocator
    property :url
    property :locationCopy
    property :locationCopyShelfLocator
    property :locationCopyEnumerationAndChronologyBasic
    property :namePrincipal
    property :name
    property :note
    property :statementOfResponsibility
    property :noteGroup
    property :noteGroupNote
    property :noteGroupType
    property :edition
    property :frequency
    property :dateIssued
    
    # part
    property :part
    property :partOrder
    property :partLevel
    property :partCaption
    property :partNumber
    
    
    property :form
    property :reformattingQuality
    property :mediaType
    property :extent
    property :digitalOrigin
    
    #relatedItem
    property :relatedHost
    property :relatedReferencedBy
    property :relatedOriginal
    property :relatedFormat
    property :relatedVersion
    property :relatedPreceding
    property :relatedReference
    property :relatedReview
    property :relatedSeries
    property :relatedSucceeding
    
    #subject
    property :subjectTopic
    property :subjectTitle
    property :subjectTemporal
    property :subjectOccupation
    property :subjectName
    property :subjectHierarchicalGeographic
    property :subjectGeographicCode
    property :subjectGeographic
    property :subjectGenre
    property :subjectComplex
    property :cartographics
    
    #table of contents
    property :tableOfContents
    
    # target audience
    property :targetAudience
  
  end
end
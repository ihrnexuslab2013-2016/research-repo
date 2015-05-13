module MODS
  class MODSRDFVocabulary < RDF::Vocabulary("http://www.loc.gov/mods/modsrdf/v1#")
    
    MODS_NS = "http://www.loc.gov/mods/modsrdf/v1#"
    RDFS_NS = "http://www.w3.org/2000/01/rdf-schema#"
    MADSRDF_NS = "http://www.loc.gov/mads/rdf/v1#"
    RDF_NS = "http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   
   
    property :titlePrincipal
    property :titleUniform
    property :abstract
    property :accessCondition
    property :genre
    property :languageOfResource
    property :locationOfResource
    property :locationPhysicalLocation
    property :locationShelfLocator
    property :locationCopy
    property :locationCopyShelfLocator
    property :locationCopyEnumerationAndChronologyBasic
    property :namePrincipal
    property :name
  
  end
end
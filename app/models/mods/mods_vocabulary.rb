module MODS
  class MODSVocabulary < RDF::Vocabulary("http://www.loc.gov/mods/modsrdf/v1#")
    
    MODS_NS = "http://www.loc.gov/mods/modsrdf/v1#"
    RDFS_NS = "http://www.w3.org/2000/01/rdf-schema#"
    MADSRDF_NS = "http://www.loc.gov/mads/rdf/v1#"
    RDF_NS = "http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   
   
    property :titlePrincipal
    property :titleUniform
  
  end
end
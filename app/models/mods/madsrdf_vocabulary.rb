module MODS
  class MADSRDFVocabulary < RDF::Vocabulary("http://www.loc.gov/mads/rdf/v1#")
    
    property :authoritativeLabel
    property :continent
    property :country
    property :province
    property :region
    property :state
    property :territory
    property :county
    property :city
    property :citySection
    property :island
    property :area
    property :extraterrestrialArea
  
  end
end
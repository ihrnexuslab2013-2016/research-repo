module MODS
  class MODSVocabulary < RDF::Vocabulary("http://www.loc.gov/mods/v3#") 
    property :titleInfo
    property :hasTitle
    property :answer
  end
end
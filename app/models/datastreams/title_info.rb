require "active-fedora"

class TitleInfo < ActiveTriples::Resource
  configure type: ModsVocabulary.TitleInfo
  
  property :title, predicate: RDF::URI.new("http://www.loc.gov/mods/v3#title"), multiple: false
end
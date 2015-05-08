module MODS
  class TitleInfo < ActiveFedora::Base
    property :label, predicate: ::RDF::URI.new(MODS::MODSVocabulary::RDFS_NS + "label"), multiple: false
    has_and_belongs_to_many :hasAbbreviatedVariant, predicate: ::RDF::URI.new(MODS::MODSVocabulary::MADSRDF_NS + "hasAbbreviatedVariant"), :class_name => "MODS::MADSTitle"
    
    
  end
end
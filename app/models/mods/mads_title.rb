module MODS
  class MADSTitle < ActiveFedora::Base
    property :label, predicate: ::RDF::URI.new(MODS::MODSVocabulary::RDFS_NS + "label"), multiple: false
  end
end
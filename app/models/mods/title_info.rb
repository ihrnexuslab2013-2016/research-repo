module MODS
  class TitleInfo < ActiveFedora::Base
    property :label, predicate: MODS::RDFSVocabulary.label, multiple: false do |index|
       index.as :stored_searchable, :facetable
    end
    has_and_belongs_to_many :hasAbbreviatedVariant, predicate: ::RDF::URI.new(MODS::MODSRDFVocabulary::MADSRDF_NS + "hasAbbreviatedVariant"), :class_name => "MODS::MADS::Title"
    accepts_nested_attributes_for :hasAbbreviatedVariant
    
  end
end
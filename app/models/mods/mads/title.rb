module MODS
  module MADS
    class Title < ActiveFedora::Base
      property :label, predicate: MODS::RDFSVocabulary.label, multiple: false do |index|
         index.as :stored_searchable, :facetable
      end
      
      has_and_belongs_to_many :has_abbreviated_variant, predicate: MODS::MODSRDFVocabulary.hasAbbreviatedVariant, :class_name => "MODS::MADS::Title"
      accepts_nested_attributes_for :has_abbreviated_variant
      
      has_and_belongs_to_many :has_translated_variant, predicate: MODS::MODSRDFVocabulary.hasTranslatedVariant, :class_name => "MODS::MADS::Title"
      accepts_nested_attributes_for :has_translated_variant
      
      has_and_belongs_to_many :has_alternative_variant, predicate: MODS::MODSRDFVocabulary.hasAlternativeVariant, :class_name => "MODS::MADS::Title"
      accepts_nested_attributes_for :has_alternative_variant
      
    end
  end
end
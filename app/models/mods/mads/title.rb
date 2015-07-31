module MODS
  module MADS
    class Title < LabelProperty
      
      # has_and_belongs_to_many :has_abbreviated_variant, predicate: MODS::MODSRDFVocabulary.hasAbbreviatedVariant, :class_name => "MODS::MADS::Title"
      # accepts_nested_attributes_for :has_abbreviated_variant
#       
      # has_and_belongs_to_many :has_translated_variant, predicate: MODS::MODSRDFVocabulary.hasTranslatedVariant, :class_name => "MODS::MADS::Title"
      # accepts_nested_attributes_for :has_translated_variant
#       
      # has_and_belongs_to_many :has_alternative_variant, predicate: MODS::MODSRDFVocabulary.hasAlternativeVariant, :class_name => "MODS::MADS::Title"
      # accepts_nested_attributes_for :has_alternative_variant
#       
      property :abbreviated_variant, predicate: MODS::MODSRDFVocabulary.hasAbbreviatedVariant, multiple: true do |index|
        index.as :stored_searchable, :facetable
      end
      
      property :translated_variant, predicate: MODS::MODSRDFVocabulary.hasTranslatedVariant, multiple: true do |index|
        index.as :stored_searchable, :facetable
      end
      
      property :alternative_variant, predicate: MODS::MODSRDFVocabulary.hasAlternativeVariant, multiple: true do |index|
        index.as :stored_searchable, :facetable
      end
      
      def abbreviated_variant=(input)
        if !input.kind_of?(Array)
          input = [input]
        end
        super input
      end
    end
  end
end
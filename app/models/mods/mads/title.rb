module MODS
  module MADS
    class Title < LabelProperty
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
      
      def translated_variant=(input)
        if !input.kind_of?(Array)
          input = [input]
        end
        super input
      end
      
      def alternative_variant=(input)
        if !input.kind_of?(Array)
          input = [input]
        end
        super input
      end
    end
  end
end
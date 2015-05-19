module MODS
  class LabelProperty < ActiveFedora::Base
    property :label, predicate: MODS::RDFSVocabulary.label, multiple: false do |index|
       index.as :stored_searchable, :facetable
    end
    
    def is_filled?
      return !self.label.strip.empty?
    end
  end
end
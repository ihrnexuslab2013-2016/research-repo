module MODS
  class Part < ActiveFedora::Base
    property :part_order, predicate: MODS::MODSRDFVocabulary.partOrder, multiple: false do |index|
       index.as :stored_searchable, :facetable
    end
    property :part_level, predicate: MODS::MODSRDFVocabulary.partLevel, multiple: false do |index|
       index.as :stored_searchable, :facetable
    end
    property :part_caption, predicate: MODS::MODSRDFVocabulary.partCaption, multiple: false do |index|
       index.as :stored_searchable, :facetable
    end
    property :part_number, predicate: MODS::MODSRDFVocabulary.partNumber, multiple: false do |index|
       index.as :stored_searchable, :facetable
    end
    
    def is_filled?
      !self.part_order.strip.empty? or !self.part_level.strip.empty? or !self.part_caption.strip.empty? or !self.part_number.strip.empty?
    end
  end
end
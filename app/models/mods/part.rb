module MODS
  class Part < ActiveFedora::Base
    property :partOrder, predicate: MODS::RDFSVocabulary.label, multiple: false do |index|
       index.as :stored_searchable, :facetable
    end
    property :partLevel, predicate: MODS::RDFSVocabulary.label, multiple: false do |index|
       index.as :stored_searchable, :facetable
    end
    property :partCaption, predicate: MODS::RDFSVocabulary.label, multiple: false do |index|
       index.as :stored_searchable, :facetable
    end
    property :partNumber, predicate: MODS::RDFSVocabulary.label, multiple: false do |index|
       index.as :stored_searchable, :facetable
    end
    
    def is_filled?
      !self.partOrder.strip.empty? or !self.partLevel.strip.empty? or !self.partCaption.strip.empty? or !self.partNumber.strip.empty?
    end
  end
end
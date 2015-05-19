module MODS
  class LocationCopy < ActiveFedora::Base
    property :locationCopyShelfLocator, predicate: MODS::MODSRDFVocabulary.locationCopyShelfLocator, multiple: false do |index|
       index.as :stored_searchable, :facetable
    end
    property :locationCopyEnumerationAndChronologyBasic, predicate: MODS::MODSRDFVocabulary.locationCopyEnumerationAndChronologyBasic, multiple: false do |index|
       index.as :stored_searchable, :facetable
    end
    
    has_and_belongs_to_many :locationCopies, :predicate => MODS::MODSRDFVocabulary.locationCopy, :class_name => "MODS::LocationCopy"
    accepts_nested_attributes_for :locationCopies
    
    def is_filled?
      return (!self.locationCopyShelfLocator.strip.empty? or !self.locationCopyEnumerationAndChronologyBasic.strip.empty?)
    end
  end
end
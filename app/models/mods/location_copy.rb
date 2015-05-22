module MODS
  class LocationCopy < ActiveFedora::Base
    property :location_copy_shelf_locator, predicate: MODS::MODSRDFVocabulary.locationCopyShelfLocator, multiple: false do |index|
       index.as :stored_searchable, :facetable
    end
    property :location_copy_enumeration_and_chronology_basic, predicate: MODS::MODSRDFVocabulary.locationCopyEnumerationAndChronologyBasic, multiple: false do |index|
       index.as :stored_searchable, :facetable
    end
     
    def is_filled?
      return (!self.locationCopyShelfLocator.strip.empty? or !self.locationCopyEnumerationAndChronologyBasic.strip.empty?)
    end
  end
end
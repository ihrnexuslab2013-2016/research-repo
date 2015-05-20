module MODS
  class Location < ActiveFedora::Base
    property :location_physical, predicate: MODS::MODSRDFVocabulary.locationPhysical, multiple: false do |index|
       index.as :stored_searchable, :facetable
    end
    property :location_shelf_locator, predicate: MODS::MODSRDFVocabulary.locationShelfLocator, multiple: false do |index|
       index.as :stored_searchable, :facetable
    end
    
    def is_filled?
      return (!self.location_physical.strip.empty? or !self.location_shelf_locator.strip.empty?)
    end
  end
end
module MODS
  class Location < ActiveFedora::Base
    property :locationPhysical, predicate: MODS::MODSRDFVocabulary.locationPhysical, multiple: false do |index|
       index.as :stored_searchable, :facetable
    end
    property :locationShelfLocator, predicate: MODS::MODSRDFVocabulary.locationShelfLocator, multiple: false do |index|
       index.as :stored_searchable, :facetable
    end
    
    def is_filled?
      return (!self.locationPhysical.strip.empty? or !self.locationShelfLocator.strip.empty?)
    end
  end
end
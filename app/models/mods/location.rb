module MODS
  class Location < ActiveFedora::Base
    property :locationPhysical, predicate: MODS::MODSRDFVocabulary.locationPhysical, multiple: false do |index|
       index.as :stored_searchable, :facetable
    end
    property :locationShelfLocator, predicate: MODS::MODSRDFVocabulary.locationShelfLocator, multiple: false do |index|
       index.as :stored_searchable, :facetable
    end
  end
end
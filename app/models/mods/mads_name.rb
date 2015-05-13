module MODS
  class MADSName < ActiveFedora::Base
    property :label, predicate: MODS::RDFSVocabulary.label, multiple: false do |index|
       index.as :stored_searchable, :facetable
    end
    
    property :relation, predicate: MODS::RDFSVocabulary.label, multiple: false do |index|
       index.as :stored_searchable, :facetable
    end
    
    # this is a shortcut for storing role information, it can be turned into proper rdf triples
    # if requested
    # this field should hold the MARC relationship information, e.g. "actor" or "depicted"
    property :role, predicate: MODS::MODSVocabulary.role, multiple: false do |index|
       index.as :stored_searchable, :facetable
    end
  end
end
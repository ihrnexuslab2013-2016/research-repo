require 'mods'

class TitleInfo < ActiveFedora::Base
  extend ActiveSupport::Concern
    
  property :title, predicate: ::KarkinosRDF::MODS.title do |index|
    index.as :stored_searchable, :facetable
  end
  
  belongs_to :generic_file, predicate: ::KarkinosRDF::MODS.titleinfo
  
end

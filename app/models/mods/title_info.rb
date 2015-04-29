require "active-fedora"

module MODS
  class TitleInfo < ActiveFedora::Base
    property :title, predicate: ::RDF::URI.new("http://www.loc.gov/mods/v3#title"), multiple: false
    
    #belongs_to :example, predicate: ActiveFedora::RDF::Fcrepo::RelsExt.isPartOf
  end
end
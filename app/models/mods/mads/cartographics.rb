module MODS
  module MADS
    class Cartographics < LabelProperty
      #  One or more statements may be supplied. If one is supplied, it is a point (i.e., a single location); 
      # if two, it is a line; if more than two, it is an n-sided polygon where n=number of coordinates assigned. 
      # No three points should be co-linear, and coordinates should be supplied in polygon-traversal order.
      property :coordinates, predicate: MODS::MADSRDFVocabulary.cartographicsCoordinates, multiple: true do |index|
         index.as :stored_searchable, :facetable
      end
      
      # <scale> may include any equivalency statements, vertical scales, or vertical exaggeration statements 
      # for relief models and other three-dimensional items.
      property :scale, predicate: MODS::MADSRDFVocabulary.cartographicsScale, multiple: true do |index|
         index.as :stored_searchable, :facetable
      end
      
      # Includes the name of the projection and any associated information related to the properties 
      # of the projection, where applicable.
      property :projection, predicate: MODS::MADSRDFVocabulary.cartographicsProjection, multiple: true do |index|
         index.as :stored_searchable, :facetable
      end
    end
  end
end
module MODS
  module MADS
    class HierarchicalGeographic < LabelProperty

      #  <continent> – Includes Asia, Africa, Europe, North America, South America.
      property :continent, predicate: MODS::MADSRDFVocabulary.continent, multiple: false do |index|
         index.as :stored_searchable, :facetable
      end
      
      # <country> – Name of a country, i.e. a political entity considered a country.
      property :country, predicate: MODS::MADSRDFVocabulary.country, multiple: false do |index|
         index.as :stored_searchable, :facetable
      end
      
      # <province> – Includes first order political divisions called provinces within a country, e.g. in Canada.
      property :province, predicate: MODS::MADSRDFVocabulary.province, multiple: false do |index|
         index.as :stored_searchable, :facetable
      end
      
      # <region> – Includes regions that have status as a jurisdiction, usually incorporating more than one first level jurisdiction.
      property :region, predicate: MODS::MADSRDFVocabulary.region, multiple: false do |index|
         index.as :stored_searchable, :facetable
      end
      
      # <state> – Includes first order political divisions called states within a country, 
      # e.g. in U.S., Argentina, Italy. Use also for France département.
      property :state, predicate: MODS::MADSRDFVocabulary.state, multiple: false do |index|
         index.as :stored_searchable, :facetable
      end

      # <territory> – Name of a geographical area belonging to or under the jurisdiction of a governmental authority.
      property :territory, predicate: MODS::MADSRDFVocabulary.territory, multiple: false do |index|
         index.as :stored_searchable, :facetable
      end
      
      # <county> – Name of the largest local administrative unit in various countries, e.g. in England.
      property :county, predicate: MODS::MADSRDFVocabulary.county, multiple: false do |index|
         index.as :stored_searchable, :facetable
      end
      
      # <city> – Name of an inhabited place incorporated as a city, town, etc.
      property :city, predicate: MODS::MADSRDFVocabulary.city, multiple: false do |index|
         index.as :stored_searchable, :facetable
      end
      
      # <citySection> – Name of a smaller unit within a populated place, e.g., neighborhoods, parks, or streets.
      property :city_section, predicate: MODS::MADSRDFVocabulary.citySection, multiple: false do |index|
         index.as :stored_searchable, :facetable
      end
      
      # <island> – Name of a tract of land surrounded by water and smaller than a continent but is not itself a separate country.
      property :island, predicate: MODS::MADSRDFVocabulary.island, multiple: false do |index|
         index.as :stored_searchable, :facetable
      end
          
      # <area> – Name of a non-jurisdictional geographic entity.
      property :area, predicate: MODS::MADSRDFVocabulary.area, multiple: false do |index|
         index.as :stored_searchable, :facetable
      end
      
      # <extraterrestrialArea> Name of any extraterrestrial entity or space, including solar systems, galaxies, 
      # star systems, and planets as well as geographic features of individual planets.
      property :extraterrestrial_area, predicate: MODS::MADSRDFVocabulary.extraterrestrialArea, multiple: false do |index|
         index.as :stored_searchable, :facetable
      end
      
    end
  end
end
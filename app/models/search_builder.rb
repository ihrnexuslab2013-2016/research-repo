class SearchBuilder < Blacklight::SearchBuilder
  include Blacklight::Solr::SearchBuilderBehavior
  include Hydra::AccessControlsEnforcement
  include Sufia::SearchBuilder

  # adds limits search results just to GenericFiles metadata
  # @param solr_parameters the current solr parameters
  # @param user_parameters the current user-subitted parameters
  def add_metadata_to_limits(solr_parameters)
    solr_parameters[:fq] ||= []
    puts "parameters +++++++++++++++++++"
    puts solr_parameters
    solr_parameters[:fq] << "#{Solrizer.solr_name("has_model", :symbol)}:(\"GenericFile\" \"Collection\" \"MODS::MADS::Cartographics\" \"MODS::Genre\" \"MODS::Location\" \"MODS::MADS::Name\" \"MODS::NoteGroup\" \"MODS::Part\" \"MODS::MADS::GenreForm\" \"MODS::MADS::Geographic\" \"MODS::MADS::HierarchicalGeographic\" \"MODS::MADS::Occupation\" \"MODS::MADS::Topic\" \"MODS::MADS::Title\")"
    puts solr_parameters
  end
end

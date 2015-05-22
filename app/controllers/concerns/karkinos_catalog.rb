module KarkinosCatalog
    extend ActiveSupport::Concern
    included do
      self.search_params_logic += [:add_metadata_to_limits]
    end
  end
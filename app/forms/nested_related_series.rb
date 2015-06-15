module NestedRelatedSeries
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { related_series_attributes: permitted_related_series_params }
      permitted
    end

    def permitted_related_series_params
      [:id]
    end

  end

  def related_series_attributes= attributes
    # do nothing, we don't want to change a linked generic file
  end
end
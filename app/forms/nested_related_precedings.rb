module NestedRelatedPrecedings
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { related_precedings_attributes: permitted_related_precedings_params }
      permitted
    end

    def permitted_related_precedings_params
      [:id]
    end

  end

  def related_precedings_attributes= attributes
    # do nothing, we don't want to change a linked generic file
  end
end
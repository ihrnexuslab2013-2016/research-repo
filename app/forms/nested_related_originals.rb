module NestedRelatedOriginals
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { related_originals_attributes: permitted_related_originals_params }
      permitted
    end

    def permitted_related_originals_params
      [:id]
    end

  end

  def related_originals_attributes= attributes
    # do nothing, we don't want to change a linked generic file
  end
end
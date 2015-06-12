module NestedRelatedReferences
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { related_references_attributes: permitted_related_references_params }
      permitted
    end

    def permitted_related_references_params
      [:id]
    end

  end

  def related_references_attributes= attributes
    # do nothing, we don't want to change a linked generic file
  end
end
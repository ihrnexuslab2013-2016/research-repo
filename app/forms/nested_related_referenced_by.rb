module NestedRelatedReferencedBy
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { related_referenced_by_attributes: permitted_related_referenced_by_params }
      permitted
    end

    def permitted_related_referenced_by_params
      [:id]
    end

  end

  def related_referenced_by_attributes= attributes
    # do nothing, we don't want to change a linked generic file
  end
end
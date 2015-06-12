module NestedRelatedVersions
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { related_versions_attributes: permitted_related_versions_params }
      permitted
    end

    def permitted_related_versions_params
      [:id]
    end

  end

  def related_versions_attributes= attributes
    # do nothing, we don't want to change a linked generic file
  end
end
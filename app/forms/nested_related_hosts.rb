module NestedRelatedHosts
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { related_hosts_attributes: permitted_related_hosts_params }
      permitted
    end

    def permitted_related_hosts_params
      [:id]
    end

  end

  def related_hosts_attributes= attributes
    # do nothing, we don't want to change a linked generic file
  end
end
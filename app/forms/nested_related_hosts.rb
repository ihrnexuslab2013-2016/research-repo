module NestedRelatedHosts
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { related_host_attributes: permitted_related_hosts_params }
      permitted
    end

    def permitted_related_hosts_params
      [:id]
    end

  end

  def related_host_attributes= attributes
    puts "setting resalted host-------------------"
    puts attributes
    id = attributes[:id]
    file = GenericFile.find(id)
    model.generic_file_related_host = [file]
  end

end
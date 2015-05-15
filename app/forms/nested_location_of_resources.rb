module NestedLocationOfResources
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { location_of_resources_attributes: permitted_location_of_resources_params }
      permitted
    end

    def permitted_location_of_resources_params
      [:label, :id]
    end

  end

  def location_of_resources_attributes= attributes
    model.location_of_resources_attributes= attributes
  end

end
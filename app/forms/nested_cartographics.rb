module NestedCartographics
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { cartographics_attributes: permitted_cartographics_params }
      permitted
    end

    def permitted_cartographics_params
      [:label, :id]
    end

  end

  def cartographics_attributes= attributes
    model.cartographics_attributes= attributes
  end

end
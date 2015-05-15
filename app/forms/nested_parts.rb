module NestedParts
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { parts_attributes: permitted_parts_params }
      permitted
    end

    def permitted_parts_params
      [:label, :id]
    end

  end

  def parts_attributes= attributes
    model.parts_attributes= attributes
  end

end
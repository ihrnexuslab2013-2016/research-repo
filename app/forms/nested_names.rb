module NestedNames
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { names_attributes: permitted_names_params }
      permitted
    end

    def permitted_names_params
      [:label, :id]
    end

  end

  def names_attributes= attributes
    model.names_attributes= attributes
  end

end
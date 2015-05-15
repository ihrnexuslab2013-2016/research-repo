module NestedNamePrincipals
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { name_principals_attributes: permitted_name_principals_params }
      permitted
    end

    def permitted_name_principals_params
      [:label, :id]
    end

  end

  def name_principals_attributes= attributes
    model.name_principals_attributes= attributes
  end

end
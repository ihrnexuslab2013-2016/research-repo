module NestedTitlePrincipals
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { title_principals_attributes: permitted_title_principals_params }
      permitted
    end

    def permitted_title_principals_params
      [:label, :abbreviated_variant, :translated_variant, :alternative_variant, :id]
    end

  end

  def title_principals_attributes= attributes
    model.title_principals_attributes= attributes
  end

end
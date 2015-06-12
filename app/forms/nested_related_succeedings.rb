module NestedRelatedSucceedings
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { related_succeedings_attributes: permitted_related_succeedings_params }
      permitted
    end

    def permitted_related_succeedings_params
      [:id]
    end

  end

  def related_succeedings_attributes= attributes
    # do nothing, we don't want to change a linked generic file
  end
end
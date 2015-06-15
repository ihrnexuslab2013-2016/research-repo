module NestedRelatedFormats
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { related_formats_attributes: permitted_related_formats_params }
      permitted
    end

    def permitted_related_formats_params
      [:id]
    end

  end

  def related_formats_attributes= attributes
    # do nothing, we don't want to change a linked generic file
  end
end
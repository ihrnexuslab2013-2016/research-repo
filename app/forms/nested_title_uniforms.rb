module NestedTitleUniforms
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { title_uniforms_attributes: permitted_title_uniforms_params }
      permitted
    end

    def permitted_title_uniforms_params
      [:label, :id]
    end

  end

  def title_uniforms_attributes= attributes
    model.title_uniforms_attributes= attributes
  end

end
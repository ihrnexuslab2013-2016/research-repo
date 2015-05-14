module NestedSubjectGeographics
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { subject_geographics_attributes: permitted_subject_geographics_params }
      permitted
    end

    def permitted_subject_geographics_params
      [:label, :id]
    end

  end

  def subject_geographics_attributes= attributes
    model.subject_geographics_attributes= attributes
  end

end
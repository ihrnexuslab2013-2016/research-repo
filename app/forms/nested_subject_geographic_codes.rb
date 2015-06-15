module NestedSubjectGeographicCodes
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { subject_geographic_codes_attributes: permitted_subject_geographic_codes_params }
      permitted
    end

    def permitted_subject_geographic_codes_params
      [:label, :id]
    end

  end

  def subject_geographic_codes_attributes= attributes
    model.subject_geographic_codes_attributes= attributes
  end

end
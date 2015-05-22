module NestedSubjectOccupations
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { subject_occupations_attributes: permitted_subject_occupations_params }
      permitted
    end

    def permitted_subject_occupations_params
      [:label, :id]
    end

  end

  def subject_occupations_attributes= attributes
    model.subject_occupations_attributes= attributes
  end

end
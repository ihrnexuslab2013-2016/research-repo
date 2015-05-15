module NestedSubjectOccupations
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { subject_occupation_attributes: permitted_subject_occupation_params }
      permitted
    end

    def permitted_subject_occupation_params
      [:label, :id]
    end

  end

  def subject_occupation_attributes= attributes
    model.subject_occupation_attributes= attributes
  end

end
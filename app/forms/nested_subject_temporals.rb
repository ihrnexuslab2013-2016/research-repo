module NestedSubjectTemporals
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { subject_temporals_attributes: permitted_subject_temporals_params }
      permitted
    end

    def permitted_subject_temporals_params
      [:label, :id]
    end

  end

  def subject_temporals_attributes= attributes
    model.subject_temporals_attributes= attributes
  end

end
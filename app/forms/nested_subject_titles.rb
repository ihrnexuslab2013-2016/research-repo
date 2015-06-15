module NestedSubjectTitles
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { subject_titles_attributes: permitted_subject_titles_params }
      permitted
    end

    def permitted_subject_titles_params
      [:label, :id]
    end

  end

  def subject_titles_attributes= attributes
    model.subject_titles_attributes= attributes
  end

end
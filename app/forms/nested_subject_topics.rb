module NestedSubjectTopics
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { subject_topics_attributes: permitted_subject_topics_params }
      permitted
    end

    def permitted_subject_topics_params
      [:label, :id]
    end

  end

  def subject_topics_attributes= attributes
    model.subject_topics_attributes= attributes
  end

end
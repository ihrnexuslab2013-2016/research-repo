module NestedSubjectGenres
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { subject_genres_attributes: permitted_subject_genres_params }
      permitted
    end

    def permitted_subject_genres_params
      [:label, :id]
    end

  end

  def subject_genres_attributes= attributes
    model.subject_genres_attributes= attributes
  end

end
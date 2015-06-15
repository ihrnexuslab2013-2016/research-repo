module NestedGenres
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { genres_attributes: permitted_genres_params }
      permitted
    end

    def permitted_genres_params
      [:label, :id]
    end

  end

  def genres_attributes= attributes
    model.genres_attributes= attributes
  end

end
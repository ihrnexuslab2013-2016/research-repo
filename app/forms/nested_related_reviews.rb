module NestedRelatedReviews
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { related_reviews_attributes: permitted_related_reviews_params }
      permitted
    end

    def permitted_related_reviews_params
      [:id]
    end

  end

  def related_reviews_attributes= attributes
    # do nothing, we don't want to change a linked generic file
  end
end
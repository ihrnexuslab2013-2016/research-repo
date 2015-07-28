module NestedSubjectHierarchicalGeographics
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { subject_hierarchical_geographics_attributes: permitted_subject_hierarchical_geographics_params }
      permitted
    end

    def permitted_subject_hierarchical_geographics_params
      [:continent, :country, :province, :region, :state, :territory, :county, :city, :city_section, :island, :area, :extraterrestrial_area, :id]
    end

  end

  def subject_hierarchical_geographics_attributes= attributes
    model.subject_hierarchical_geographics_attributes= attributes
  end

end
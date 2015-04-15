class DatafilePresenter < Sufia::GenericFilePresenter
  include AttributeHelper
  
  attr_accessor :type_fields_map
  
  self.terms = [:resource_type, :title, :rights, :date_uploaded]
  
  def initialize(object)
    super
    resource_types object.resource_type
  end
  
  def resource_types(types)
    @type_fields_map = Hash.new
    
    types.each do |type|
      get_type_field_symbols type
    end
  end
  
end
class DatafilePresenter < Sufia::GenericFilePresenter
  include AttributeHelper
  self.model_class = ::DataFile
  
  attr_accessor :type_fields_map
  
  
  self.terms = [:title, :rights, :date_uploaded]
  
  @@nested_terms = []
  
  def nested_terms
    @@nested_terms
  end
  
  
  def initialize(object)
    super
    #resource_types object.resource_type
  end

  def resource_types(types)
    @type_fields_map = Hash.new
    
    types.each do |type|
      get_type_field_symbols type
    end
  end
 
end
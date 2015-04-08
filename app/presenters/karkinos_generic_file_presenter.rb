class KarkinosGenericFilePresenter < Sufia::GenericFilePresenter
  include AttributeHelper
  
  attr_accessor :type_fields_map
  attr_accessor :use_fields
  attr_accessor :use
  
  def initialize(object)
      super
        
      @type_fields_map = Hash.new
      
      types = object.resource_type
      types.each do |type|
        get_type_field_symbols type
      end
      
      @use = object.use
      get_use_fields_symbols @use
      
  end
  
  def resource_types(types)
    @type_fields_map = Hash.new
    
    types.each do |type|
      get_type_field_symbols type
    end
  end
  
  def use=(use)
      @use = use
      get_use_fields_symbols use
  end
  
  self.terms = [:resource_type, :title, :creator, :contributor, :description, :tag, :rights,
        :publisher, :date_created, :subject, :language, :identifier, :based_near, :related_url, :use]
end
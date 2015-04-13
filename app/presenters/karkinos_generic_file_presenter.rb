class KarkinosGenericFilePresenter < Sufia::GenericFilePresenter
  include AttributeHelper
  
  attr_accessor :type_fields_map
  attr_accessor :use_fields_map
  
  def initialize(object)
      super
        
      @type_fields_map = Hash.new
      
      types = object.resource_type
      types.each do |type|
        get_type_field_symbols type
      end
      
      @use_fields_map = Hash.new
      uses = object.use
      uses.each do |use|
        get_use_fields_symbols use
      end
      
  end
  
  def resource_types(types)
    @type_fields_map = Hash.new
    
    types.each do |type|
      get_type_field_symbols type
    end
  end
  
  def uses=(uses)
      @use_fields_map = Hash.new
      
      uses.each do |use|
        get_use_fields_symbols use
      end
  end
  
  self.terms = [:resource_type, :title, :creator, :contributor, :description, :tag, :rights,
        :publisher, :date_created, :subject, :language, :identifier, :based_near, :related_url, :use]
end
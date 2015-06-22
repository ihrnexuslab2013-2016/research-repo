class DatafilePresenter < Sufia::GenericFilePresenter
  include AttributeHelper
  self.model_class = ::DataFile
  
  attr_accessor :type_fields_map
  attr_accessor :display_terms
  attr_accessor :always_present_terms
  
  self.terms = [:title, :rights, :date_uploaded, :use]
  @@always_present_terms = [:use]
  
  
  def initialize(object)
    super
    @display_terms = Hash[*self.class.terms.zip(self.class.terms).flatten.compact]
    #@display_terms = Hash[*@@always_present_terms.zip(@@always_present_terms).flatten.compact].merge(@display_terms)
  end

  def resource_types(types)
    @type_fields_map = Hash.new
    
    types.each do |type|
      get_type_field_symbols type
    end
  end
 
end
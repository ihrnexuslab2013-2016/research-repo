class KarkinosGenericFilePresenter < Sufia::GenericFilePresenter
  
  attr_accessor :type_fields_map
  attr_accessor :use_fields
  attr_accessor :use
  
  def initialize(object)
      super
        
      @type_fields_map = Hash.new
      
      types = object.resource_type
      types.each do |type|
        filename = type.to_s.parameterize.underscore + ".yml"
      
        type_fields = []
        # add additional type fields to details page
        if (File.exists?(File.dirname(__FILE__) + "/../../metadata/type/" + filename))
          yamlFile = YAML.load_file(File.dirname(__FILE__) + "/../../metadata/type/" + filename)
          
          yamlFile['fields'].each do |field|
            type_fields << field['name'].parameterize.underscore.to_sym
          end
        end
        
        @type_fields_map[type] = type_fields
      end
      
      @use = object.use
      filename = @use.to_s.parameterize.underscore + ".yml"
      @use_fields = []
      # add additional type fields to details page
      if (File.exists?(File.dirname(__FILE__) + "/../../metadata/use/" + filename))
        yamlFile = YAML.load_file(File.dirname(__FILE__) + "/../../metadata/use/" + filename)
        
        yamlFile['fields'].each do |field|
          @use_fields << field['name'].parameterize.underscore.to_sym
        end
      end
      
  end
  
  def resource_types(types)
    @type_fields_map = Hash.new
    
    types.each do |type|
      filename = type.to_s.parameterize.underscore + ".yml"
    
      type_fields = []
      # add additional type fields to details page
      if (File.exists?(File.dirname(__FILE__) + "/../../metadata/type/" + filename))
        yamlFile = YAML.load_file(File.dirname(__FILE__) + "/../../metadata/type/" + filename)
        
        yamlFile['fields'].each do |field|
          type_fields << field['name'].parameterize.underscore.to_sym
        end
      end
      
      @type_fields_map[type] = type_fields
    end
  end
  
  self.terms = [:resource_type, :title, :creator, :contributor, :description, :tag, :rights,
        :publisher, :date_created, :subject, :language, :identifier, :based_near, :related_url, :use]
end
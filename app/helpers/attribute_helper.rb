module AttributeHelper
  # get all available yaml files describing resource types
  def self.yaml_type_files
    typeFiles = Dir.glob("#{Rails.root}/metadata/type/*")
  end
  
  # get all yaml files describing uses
  def self.yaml_use_files
    typeFiles = Dir.glob("#{Rails.root}/metadata/use/*")
  end
  
  # get all availalbe resource types
  def self.type_names
    types = []
    yaml_type_files.each do |file|  
      yamlFile = YAML.load_file(file)
      types << yamlFile['type_name']
    end
    types
  end
  
  # get all available uses
  def self.use_names
    uses = []
    yaml_use_files.each do |file|  
      yamlFile = YAML.load_file(file)
      uses << yamlFile['use_name']
    end
    uses
  end
  
  # build a hash with a list of resource type fields for all given types; if types is nil, it reads all types fields from all resource types
  def self.build_type_symbol_map(types=nil)
    types = type_names if types.nil?

    type_fields_map = Hash.new
    types.each do |type|
      type_fields_map[type] = retrieve_type_fields type
    end
    
    type_fields_map
  end
  
  # retrieve all fields for a given resource type
  def self.retrieve_type_fields(type)
    filename = type.to_s.parameterize.underscore + ".yml"
    type_fields = []
    # add additional type fields to details page
    if (File.exists?("#{Rails.root}/metadata/type/" + filename))
      yamlFile = YAML.load_file("#{Rails.root}/metadata/type/" + filename)
      
      yamlFile['fields'].each do |field|
        type_fields << field['name'].parameterize.underscore.to_sym
      end
    end
    type_fields
  end
  
  # build a hash with a list of use fields for all given uses; if uses is nil, it reads all use fields from all use types
  def self.build_use_symbol_list(uses=nil)
    uses = use_names if uses.nil?
    
    uses_map = Hash.new
    uses.each do |use|
       uses_map[use] = retrieve_use_fields use
    end
    
    uses_map
  end
  
  # retrieve all fields for a given use type
  def self.retrieve_use_fields(use)
    filename = use.to_s.parameterize.underscore + ".yml"
    use_fields = []
   
    if (File.exists?("#{Rails.root}/metadata/use/" + filename))
      yamlFile = YAML.load_file("#{Rails.root}/metadata/use/" + filename)
      
      yamlFile['fields'].each do |field|
        use_fields << field['name'].parameterize.underscore.to_sym
      end
    end
    
    use_fields   
  end
  
  
  # object methods
  def get_type_field_symbols(type)
    @type_fields_map[type] = AttributeHelper::retrieve_type_fields type
  end
  
  def get_use_fields_symbols(use)
    @use_fields_map[use] = AttributeHelper::retrieve_use_fields use
  end
  
end
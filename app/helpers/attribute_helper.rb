module AttributeHelper
  def self.yaml_type_files
    typeFiles = Dir.glob("#{Rails.root}/metadata/type/*")
  end
  
  def self.yaml_use_files
    typeFiles = Dir.glob("#{Rails.root}/metadata/use/*")
  end
  
  def self.type_names
    types = []
    yaml_type_files.each do |file|  
      yamlFile = YAML.load_file(file)
      types << yamlFile['type_name']
    end
    types
  end
  
  def self.use_names
    uses = []
    yaml_use_files.each do |file|  
      yamlFile = YAML.load_file(file)
      uses << yamlFile['use_name']
    end
    uses
  end
  
  def self.build_type_symbol_map(types=nil)
    types = type_names if types.nil?

    type_fields_map = Hash.new
    types.each do |type|
      filename = type.to_s.parameterize.underscore + ".yml"
    
      type_fields = []
      # add additional type fields to details page
      if (File.exists?("#{Rails.root}/metadata/type/" + filename))
        yamlFile = YAML.load_file("#{Rails.root}/metadata/type/" + filename)
        
        yamlFile['fields'].each do |field|
          type_fields << field['name'].parameterize.underscore.to_sym
        end
      end
      
      type_fields_map[type] = type_fields
    end
    
    type_fields_map
  end
  
  def self.build_use_symbol_list(uses=nil)
    uses = use_names if uses.nil?
    
    uses_map = Hash.new
    uses.each do |use|
      filename = use.to_s.parameterize.underscore + ".yml"
    
      use_fields = []
      # add additional type fields to details page
      if (File.exists?("#{Rails.root}/metadata/use/" + filename))
        yamlFile = YAML.load_file("#{Rails.root}/metadata/use/" + filename)
        
        yamlFile['fields'].each do |field|
          use_fields << field['name'].parameterize.underscore.to_sym
        end
      end
      
      uses_map[use] = use_fields
    end
    
    uses_map
  end
  
  def get_type_field_symbols(type)
      filename = type.to_s.parameterize.underscore + ".yml"
      
      type_fields = []
      # add additional type fields to details page
      if (File.exists?("#{Rails.root}/metadata/type/" + filename))
        yamlFile = YAML.load_file("#{Rails.root}/metadata/type/" + filename)
        
        yamlFile['fields'].each do |field|
          type_fields << field['name'].parameterize.underscore.to_sym
        end
      end
      
      @type_fields_map[type] = type_fields
  end
  
  def get_use_fields_symbols(use)
    filename = use.to_s.parameterize.underscore + ".yml"
    @use_fields = []
    # add additional type fields to details page
    if (File.exists?("#{Rails.root}/metadata/use/" + filename))
      yamlFile = YAML.load_file("#{Rails.root}/metadata/use/" + filename)
      
      yamlFile['fields'].each do |field|
        @use_fields << field['name'].parameterize.underscore.to_sym
      end
    end
  end
  
end
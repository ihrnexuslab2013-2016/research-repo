module AttributeHelper
  def self.yaml_type_files
    typeFiles = Dir.glob("#{Rails.root}/metadata/type/*")
  end
  
  def self.yaml_use_files
    typeFiles = Dir.glob("#{Rails.root}/metadata/use/*")
  end
  
  def self.build_type_field_map(types)
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
end
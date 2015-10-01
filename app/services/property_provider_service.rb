class PropertyProviderService
  
  @@type_properties = {}
  
  class << self
    
    def get_type_properties(type)
      return @@type_properties[type] if !@@type_properties[type].nil?
      filename = type.to_s.parameterize.underscore + ".yml"
      type_fields = {}
      type_sub_fields = {}
      if (File.exists?("#{Rails.root}/metadata/type/" + filename))
        yamlFile = YAML.load_file("#{Rails.root}/metadata/type/" + filename)

        yamlFile['fields'].each do |field|
          if field.has_key?('subfields')
            field['subfields'].each do |subfield|
                type_sub_fields[subfield['name'].underscore.to_sym] = subfield['label']
            end
          end
          type_fields[field['name'].parameterize.underscore.to_sym] = {:label => field['label'], :role => field['role'], :type => field['type'], :subfields => type_sub_fields }
        end
        @@type_properties[type] = type_fields
      end
      type_fields
    end
  end
end
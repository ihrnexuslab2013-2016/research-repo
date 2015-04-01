class KarkinosGenericFilePresenter < Sufia::GenericFilePresenter
  
  attr_accessor :type_fields
  
  def initialize(object)
      super
        
      rtype = object.resource_type
      filename = rtype.to_s.parameterize.underscore + ".yml"
      
      @type_fields = []
      # add additional type fields to details page
      if (File.exists?(File.dirname(__FILE__) + "/../../metadata/type/" + filename))
        yamlFile = YAML.load_file(File.dirname(__FILE__) + "/../../metadata/type/" + filename)
        
        yamlFile['fields'].each do |field|
          @type_fields << field['name'].parameterize.underscore.to_sym
        end
      end
  end
  
  
end
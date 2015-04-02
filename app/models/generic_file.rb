class GenericFile < ActiveFedora::Base
  include Sufia::GenericFile
  
  property :use, predicate: ::RDF::URI.new('http://karkinos.asu.edu/ns#conceptualUse'), multiple: false do |index|
     index.as :stored_searchable, :facetable
  end

  typeFiles = AttributeHelper.yaml_type_files
  typeFiles.each do |file|  
    yamlFile = YAML.load_file(file)
    yamlFile['fields'].each do |field|
      property field['name'].parameterize.underscore.to_sym, predicate: ::RDF::DC.instance_eval(field['relation']), multiple: field['multiple'] ? field['multiple'] : true do |index|
        index.as :stored_searchable, :facetable
      end
    end
  end
  
  useFiles = AttributeHelper.yaml_use_files
  useFiles.each do |file|  
    yamlFile = YAML.load_file(file)
    yamlFile['fields'].each do |field|
      property field['name'].parameterize.underscore.to_sym, predicate: ::RDF::DC.instance_eval(field['relation']), multiple: field['multiple'] ? field['multiple'] : true do |index|
        index.as :stored_searchable, :facetable
      end
    end
  end
 
  
  
end
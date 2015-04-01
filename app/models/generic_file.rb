class GenericFile < ActiveFedora::Base
  include Sufia::GenericFile
  
  property :use, predicate: ::RDF::URI.new('http://karkinos.asu.edu/ns#conceptualUse') do |index|
     index.as :stored_searchable, :facetable
  end

  typeFiles = Dir[File.dirname(__FILE__) + "/../../metadata/type/*"]
    typeFiles.each do |file|  
      yamlFile = YAML.load_file(file)
      yamlFile['fields'].each do |field|
        property field['name'].parameterize.underscore.to_sym, predicate: ::RDF::DC.instance_eval(field['relation']) do |index|
        index.as :stored_searchable, :facetable
      end
    end
  end
  
  useFiles = Dir[File.dirname(__FILE__) + "/../../metadata/use/*"]
    useFiles.each do |file|  
      yamlFile = YAML.load_file(file)
      yamlFile['fields'].each do |field|
        property field['name'].parameterize.underscore.to_sym, predicate: ::RDF::DC.instance_eval(field['relation']) do |index|
        index.as :stored_searchable, :facetable
      end
    end
  end
 
  
  
end
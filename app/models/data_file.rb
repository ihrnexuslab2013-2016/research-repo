class DataFile < ActiveFedora::Base
  include Sufia::GenericFile
  
  
  typeFiles = AttributeHelper.yaml_type_files
  typeFiles.each do |file|  
    yamlFile = YAML.load_file(file)
    yamlFile['fields'].each do |field|
      pred = field['relation'].start_with?("http") || field['relation'].start_with?("https") ? ::RDF::URI.new(field['relation']) : ::RDF::DC.instance_eval(field['relation'])
      property field['name'].parameterize.underscore.to_sym, predicate: pred, multiple: field['multiple'] ? field['multiple'] : true do |index|
        index.as :stored_searchable, :facetable
      end
    end
  end
  
  belongs_to :generic_file, predicate: ActiveFedora::RDF::Fcrepo::RelsExt.isPartOf
  
end
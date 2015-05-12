require "active-fedora"

class GenericFile < ActiveFedora::Base
  include Sufia::GenericFile
  
  property :use, predicate: ::RDF::URI.new('http://karkinos.asu.edu/ns#conceptualUse'), multiple: true do |index|
     index.as :stored_searchable, :facetable
  end

  useFiles = AttributeHelper.yaml_use_files
  useFiles.each do |file|  
    yamlFile = YAML.load_file(file)
    yamlFile['fields'].each do |field|
      pred = field['relation'].start_with?("http") || field['relation'].start_with?("https") ? ::RDF::URI.new(field['relation']) : ::RDF::DC.instance_eval(field['relation'])
      property field['name'].parameterize.underscore.to_sym, predicate: pred, multiple: field['multiple'] ? field['multiple'] : true do |index|
        index.as :stored_searchable, :facetable
      end
    end
  end
 
  has_many :data_files
  
  has_and_belongs_to_many :title_principals, :predicate => MODS::MODSVocabulary.titlePrincipal, :class_name => "MODS::TitleInfo"
  accepts_nested_attributes_for :title_principals
  
  has_and_belongs_to_many :title_uniforms, :predicate => MODS::MODSVocabulary.titleUniform, :class_name => "MODS::TitleInfo"
  accepts_nested_attributes_for :title_uniforms
  
  def save(arg = {})
    self.title_principals.each do |ti|
      ti.save! 
    end
    self.title_uniforms.each do |tu|
      tu.save!
    end
    super(arg)
  end
  
  #def init_with_resource(rdf_resource)
   #super(rdf_resource)
   #self.title_principals = [MODS::TitleInfo.new] unless !self.title_principals.empty?
   #self
 # end
 
=begin
  def attributes=(attrs)
    puts attrs
    if !attrs.nil?
     self.reflections.keys.each do |attr|
        if self.class.nested_attribute? attr.to_sym
          values = attrs[attr]
          if !values.nil?
            nested_variables = self.send(attr)
            if values.respond_to? "values"
              puts "responding +++++++++++++++++++++++++"
              values.values.each do |key, value|
                nested_variables.first.send(key.to_s + '=', value)
              end
             end
            attrs.delete attr
          end
        end
      end
     end
     super
  end
=end
  
  class << self
    def multiple?(field)
      if !GenericFile.reflections[field].nil? and GenericFile.reflections[field].macro == :has_and_belongs_to_many
        return true
      end
      super
    end
    
    def nested_attribute?(field)
      !GenericFile.reflections[field].nil? and GenericFile.reflections[field].macro == :has_and_belongs_to_many
    end
  end
end
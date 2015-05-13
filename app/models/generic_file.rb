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
  
  has_and_belongs_to_many :title_principals, :predicate => MODS::MODSRDFVocabulary.titlePrincipal, :class_name => "MODS::TitleInfo"
  accepts_nested_attributes_for :title_principals
  
  has_and_belongs_to_many :title_uniforms, :predicate => MODS::MODSRDFVocabulary.titleUniform, :class_name => "MODS::TitleInfo"
  accepts_nested_attributes_for :title_uniforms
  
  property :abstract, predicate: MODS::MODSRDFVocabulary.abstract, multiple: false do |index|
     index.as :stored_searchable, :facetable
  end
  
  property :accessCondition, predicate: MODS::MODSRDFVocabulary.accessCondition, multiple: false do |index|
     index.as :stored_searchable, :facetable
  end
  
  has_and_belongs_to_many :genres, :predicate => MODS::MODSRDFVocabulary.genre, :class_name => "MODS::Genre"
  accepts_nested_attributes_for :genres
  
  property :languageOfResource, predicate: MODS::MODSRDFVocabulary.languageOfResource, multiple: false do |index|
     index.as :stored_searchable, :facetable
  end
  
  has_and_belongs_to_many :locationOfResources, :predicate => MODS::MODSRDFVocabulary.locationOfResource, :class_name => "MODS::Location"
  accepts_nested_attributes_for :locationOfResources
  
  has_and_belongs_to_many :namePrincipals, :predicate => MODS::MODSRDFVocabulary.namePrincipal, :class_name => "MODS::MADSName"
  accepts_nested_attributes_for :namePrincipals
  
  has_and_belongs_to_many :names, :predicate => MODS::MODSRDFVocabulary.name, :class_name => "MODS::MADSName"
  accepts_nested_attributes_for :names
 
  def save(arg = {})
    self.title_principals.each do |ti|
      ti.save! 
    end
    self.title_uniforms.each do |tu|
      tu.save!
    end
    self.genres.each do |g|
      g.save!
    end
    super(arg)
  end
  
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
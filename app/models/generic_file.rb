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
  
  property :abstract, predicate: MODS::MODSRDFVocabulary.abstract, multiple: true do |index|
     index.as :stored_searchable, :facetable
  end
  
  property :accessCondition, predicate: MODS::MODSRDFVocabulary.accessCondition, multiple: true do |index|
     index.as :stored_searchable, :facetable
  end
  
  has_and_belongs_to_many :genres, :predicate => MODS::MODSRDFVocabulary.genre, :class_name => "MODS::Genre"
  accepts_nested_attributes_for :genres
  
  property :languageOfResource, predicate: MODS::MODSRDFVocabulary.languageOfResource, multiple: true do |index|
     index.as :stored_searchable, :facetable
  end
  
  has_and_belongs_to_many :locationOfResources, :predicate => MODS::MODSRDFVocabulary.locationOfResource, :class_name => "MODS::Location"
  accepts_nested_attributes_for :locationOfResources
  
  has_and_belongs_to_many :namePrincipals, :predicate => MODS::MODSRDFVocabulary.namePrincipal, :class_name => "MODS::MADSName"
  accepts_nested_attributes_for :namePrincipals
  
  has_and_belongs_to_many :names, :predicate => MODS::MODSRDFVocabulary.name, :class_name => "MODS::MADSName"
  accepts_nested_attributes_for :names
 
  property :notes, predicate: MODS::MODSRDFVocabulary.note, multiple: true do |index|
     index.as :stored_searchable, :facetable
  end
  
  property :statementOfResponsibility, predicate: MODS::MODSRDFVocabulary.statementOfResponsibility, multiple: false do |index|
     index.as :stored_searchable, :facetable
  end
  
  has_and_belongs_to_many :noteGroups, :predicate => MODS::MODSRDFVocabulary.noteGroup, :class_name => "MODS::NoteGroup"
  accepts_nested_attributes_for :noteGroups
  
  property :edition, predicate: MODS::MODSRDFVocabulary.edition, multiple: false do |index|
     index.as :stored_searchable, :facetable
  end
  
  property :frequency, predicate: MODS::MODSRDFVocabulary.frequency, multiple: false do |index|
     index.as :stored_searchable, :facetable
  end
  
  property :dateIssued, predicate: MODS::MODSRDFVocabulary.dateIssued, multiple: false do |index|
     index.as :stored_searchable, :facetable
  end
  
  has_and_belongs_to_many :parts, :predicate => MODS::MODSRDFVocabulary.part, :class_name => "MODS::Part"
  accepts_nested_attributes_for :parts
  
  property :form, predicate: MODS::MODSRDFVocabulary.form, multiple: false do |index|
     index.as :stored_searchable, :facetable
  end
  
  property :reformattingQuality, predicate: MODS::MODSRDFVocabulary.reformattingQuality, multiple: false do |index|
     index.as :stored_searchable, :facetable
  end
  
  property :mediaType, predicate: MODS::MODSRDFVocabulary.mediaType, multiple: false do |index|
     index.as :stored_searchable, :facetable
  end
  
  has_and_belongs_to_many :relatedHost, :predicate => MODS::MODSRDFVocabulary.relatedHost, :class_name => "GenericFile"
  accepts_nested_attributes_for :relatedHost
  
  has_and_belongs_to_many :relatedReferencedBy, :predicate => MODS::MODSRDFVocabulary.relatedReferencedBy, :class_name => "GenericFile"
  accepts_nested_attributes_for :relatedReferencedBy
  
  has_and_belongs_to_many :relatedOriginal, :predicate => MODS::MODSRDFVocabulary.relatedOriginal, :class_name => "GenericFile"
  accepts_nested_attributes_for :relatedOriginal
  
  has_and_belongs_to_many :relatedFormat, :predicate => MODS::MODSRDFVocabulary.relatedFormat, :class_name => "GenericFile"
  accepts_nested_attributes_for :relatedFormat
  
  has_and_belongs_to_many :relatedVersion, :predicate => MODS::MODSRDFVocabulary.relatedVersion, :class_name => "GenericFile"
  accepts_nested_attributes_for :relatedVersion
  
  has_and_belongs_to_many :relatedPreceding, :predicate => MODS::MODSRDFVocabulary.relatedPreceding, :class_name => "GenericFile"
  accepts_nested_attributes_for :relatedPreceding
  
  has_and_belongs_to_many :relatedReference, :predicate => MODS::MODSRDFVocabulary.relatedReference, :class_name => "GenericFile"
  accepts_nested_attributes_for :relatedReference
  
  has_and_belongs_to_many :relatedReview, :predicate => MODS::MODSRDFVocabulary.relatedReview, :class_name => "GenericFile"
  accepts_nested_attributes_for :relatedReview
  
  has_and_belongs_to_many :relatedSeries, :predicate => MODS::MODSRDFVocabulary.relatedSeries, :class_name => "GenericFile"
  accepts_nested_attributes_for :relatedSeries
  
  has_and_belongs_to_many :relatedSucceeding, :predicate => MODS::MODSRDFVocabulary.relatedSucceeding, :class_name => "GenericFile"
  accepts_nested_attributes_for :relatedSucceeding
  
  has_and_belongs_to_many :subject_topics, :predicate => MODS::MODSRDFVocabulary.subjectTopic, :class_name => "MODS::MADS::Topic"
  accepts_nested_attributes_for :subject_topics
  
  has_and_belongs_to_many :subject_geographics, :predicate => MODS::MODSRDFVocabulary.subjectTopic, :class_name => "MODS::MADS::Geographic"
  accepts_nested_attributes_for :subject_geographics
  
  def save(arg = {})
    puts "saving +++++++++++++++++"
    self.title_principals.each do |ti|
      ti.save! 
    end
    self.title_uniforms.each do |tu|
      tu.save!
    end
    self.genres.each do |g|
      g.save!
    end
    self.subject_topics.each do |t|
      t.save!
      puts "saved +++++++++++++++++++++++++++ " + t.id.to_s
    end
    self.subject_geographics.each do |t|
      t.save!
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
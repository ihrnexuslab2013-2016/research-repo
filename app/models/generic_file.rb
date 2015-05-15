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
  
  has_and_belongs_to_many :namePrincipals, :predicate => MODS::MODSRDFVocabulary.namePrincipal, :class_name => "MODS::MADS::Name"
  accepts_nested_attributes_for :namePrincipals
  
  has_and_belongs_to_many :names, :predicate => MODS::MODSRDFVocabulary.name, :class_name => "MODS::MADS::Name"
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
  
  # subject fields
  has_and_belongs_to_many :subjectTopics, :predicate => MODS::MODSRDFVocabulary.subjectTopic, :class_name => "MODS::MADS::Topic"
  accepts_nested_attributes_for :subjectTopics
  
  has_and_belongs_to_many :subjectGeographics, :predicate => MODS::MODSRDFVocabulary.subjectGeographic, :class_name => "MODS::MADS::Geographic"
  accepts_nested_attributes_for :subjectGeographics
  
  has_and_belongs_to_many :subjectTemporals, :predicate => MODS::MODSRDFVocabulary.subjectTemporal, :class_name => "MODS::MADS::Temporal"
  accepts_nested_attributes_for :subjectTemporals
  
  has_and_belongs_to_many :subjectTitle, :predicate => MODS::MODSRDFVocabulary.subjectTitle, :class_name => "MODS::MADS::Titel"
  accepts_nested_attributes_for :subjectTitle
  
  has_and_belongs_to_many :subjectGeographicCode, :predicate => MODS::MODSRDFVocabulary.subjectGeographicCode, :class_name => "MODS::MADS::GeographicCode"
  accepts_nested_attributes_for :subjectGeographicCode
  
  has_and_belongs_to_many :subjectHierarchicalGeographic, :predicate => MODS::MODSRDFVocabulary.subjectHierarchicalGeographic, :class_name => "MODS::MADS::HierarchicalGeographic"
  accepts_nested_attributes_for :subjectHierarchicalGeographic
  
  has_and_belongs_to_many :cartographics, :predicate => MODS::MODSRDFVocabulary.cartographics, :class_name => "MODS::MADS::Cartographics"
  accepts_nested_attributes_for :cartographics
  
  has_and_belongs_to_many :subjectOccupation, :predicate => MODS::MODSRDFVocabulary.subjectOccupation, :class_name => "MODS::MADS::Occupation"
  accepts_nested_attributes_for :subjectOccupation
  
  has_and_belongs_to_many :subjectGenre, :predicate => MODS::MODSRDFVocabulary.subjectGenre, :class_name => "MODS::MADS::GenreForm"
  accepts_nested_attributes_for :subjectGenre
  
  # table of contents
  property :tableOfContents, predicate: MODS::MODSRDFVocabulary.tableOfContents, multiple: true do |index|
     index.as :stored_searchable, :facetable
  end
  
  # target audience
  property :targetAudience, predicate: MODS::MODSRDFVocabulary.targetAudience, multiple: true do |index|
     index.as :stored_searchable, :facetable
  end
  
  def save(arg = {})
    self.title_principals.each do |ti|
      ti.save! 
    end
    self.title_uniforms.each do |tu|
      tu.save!
      self.title_uniform_ids = self.title_uniform_ids + [tu.id] unless self.title_uniform_ids.include? tu.id
    end
    self.genres.each do |g|
      g.save!
      self.genre_ids = self.genre_ids + [g.id] unless self.genre_ids.include? g.id
    end
    self.subject_topics.each do |t|
      t.save!
      self.subject_topic_ids = self.subject_topic_ids + [t.id] unless self.subject_topic_ids.include? t.id
    end
    self.subject_geographics.each do |t|
      t.save!
      self.subject_geographic_ids = self.subject_geographic_ids + [t.id] unless self.subject_geographic_ids.include? t.id
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
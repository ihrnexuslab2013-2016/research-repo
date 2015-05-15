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
  
  has_and_belongs_to_many :title_principals, :predicate => MODS::MODSRDFVocabulary.titlePrincipal, :class_name => "MODS::MADS::Title"
  accepts_nested_attributes_for :title_principals, allow_destroy: true
  
  has_and_belongs_to_many :title_uniforms, :predicate => MODS::MODSRDFVocabulary.titleUniform, :class_name => "MODS::MADS::Title"
  accepts_nested_attributes_for :title_uniforms, allow_destroy: true
  
  property :abstract, predicate: MODS::MODSRDFVocabulary.abstract, multiple: true do |index|
     index.as :stored_searchable, :facetable
  end
  
  property :access_condition, predicate: MODS::MODSRDFVocabulary.accessCondition, multiple: true do |index|
     index.as :stored_searchable, :facetable
  end
  
  has_and_belongs_to_many :genres, :predicate => MODS::MODSRDFVocabulary.genre, :class_name => "MODS::Genre"
  accepts_nested_attributes_for :genres, allow_destroy: true
  
  property :language_of_resource, predicate: MODS::MODSRDFVocabulary.languageOfResource, multiple: true do |index|
     index.as :stored_searchable, :facetable
  end
  
  has_and_belongs_to_many :location_of_resources, :predicate => MODS::MODSRDFVocabulary.locationOfResource, :class_name => "MODS::Location"
  accepts_nested_attributes_for :location_of_resources, allow_destroy: true
  
  has_and_belongs_to_many :name_principals, :predicate => MODS::MODSRDFVocabulary.namePrincipal, :class_name => "MODS::MADS::Name"
  accepts_nested_attributes_for :name_principals, allow_destroy: true
  
  has_and_belongs_to_many :names, :predicate => MODS::MODSRDFVocabulary.name, :class_name => "MODS::MADS::Name"
  accepts_nested_attributes_for :names, allow_destroy: true
 
  property :notes, predicate: MODS::MODSRDFVocabulary.note, multiple: true do |index|
     index.as :stored_searchable, :facetable
  end
  
  property :statement_of_responsibility, predicate: MODS::MODSRDFVocabulary.statementOfResponsibility, multiple: false do |index|
     index.as :stored_searchable, :facetable
  end
  
  has_and_belongs_to_many :note_groups, :predicate => MODS::MODSRDFVocabulary.noteGroup, :class_name => "MODS::NoteGroup"
  accepts_nested_attributes_for :note_groups, allow_destroy: true
  
  property :edition, predicate: MODS::MODSRDFVocabulary.edition, multiple: false do |index|
     index.as :stored_searchable, :facetable
  end
  
  property :frequency, predicate: MODS::MODSRDFVocabulary.frequency, multiple: false do |index|
     index.as :stored_searchable, :facetable
  end
  
  property :date_issued, predicate: MODS::MODSRDFVocabulary.dateIssued, multiple: false do |index|
     index.as :stored_searchable, :facetable
  end
  
  has_and_belongs_to_many :parts, :predicate => MODS::MODSRDFVocabulary.part, :class_name => "MODS::Part"
  accepts_nested_attributes_for :parts, allow_destroy: true
  
  property :form, predicate: MODS::MODSRDFVocabulary.form, multiple: false do |index|
     index.as :stored_searchable, :facetable
  end
  
  property :reformatting_quality, predicate: MODS::MODSRDFVocabulary.reformattingQuality, multiple: false do |index|
     index.as :stored_searchable, :facetable
  end
  
  property :media_type, predicate: MODS::MODSRDFVocabulary.mediaType, multiple: false do |index|
     index.as :stored_searchable, :facetable
  end
  
  has_and_belongs_to_many :related_host, :predicate => MODS::MODSRDFVocabulary.relatedHost, :class_name => "GenericFile"
  accepts_nested_attributes_for :related_host
  
  has_and_belongs_to_many :related_referenced_by, :predicate => MODS::MODSRDFVocabulary.relatedReferencedBy, :class_name => "GenericFile"
  accepts_nested_attributes_for :related_referenced_by
  
  has_and_belongs_to_many :related_original, :predicate => MODS::MODSRDFVocabulary.relatedOriginal, :class_name => "GenericFile"
  accepts_nested_attributes_for :related_original
  
  has_and_belongs_to_many :related_format, :predicate => MODS::MODSRDFVocabulary.relatedFormat, :class_name => "GenericFile"
  accepts_nested_attributes_for :related_format
  
  has_and_belongs_to_many :related_version, :predicate => MODS::MODSRDFVocabulary.relatedVersion, :class_name => "GenericFile"
  accepts_nested_attributes_for :related_version
  
  has_and_belongs_to_many :related_preceding, :predicate => MODS::MODSRDFVocabulary.relatedPreceding, :class_name => "GenericFile"
  accepts_nested_attributes_for :related_preceding
  
  has_and_belongs_to_many :related_reference, :predicate => MODS::MODSRDFVocabulary.relatedReference, :class_name => "GenericFile"
  accepts_nested_attributes_for :related_reference
  
  has_and_belongs_to_many :related_review, :predicate => MODS::MODSRDFVocabulary.relatedReview, :class_name => "GenericFile"
  accepts_nested_attributes_for :related_review
  
  has_and_belongs_to_many :related_series, :predicate => MODS::MODSRDFVocabulary.relatedSeries, :class_name => "GenericFile"
  accepts_nested_attributes_for :related_series
  
  has_and_belongs_to_many :related_succeeding, :predicate => MODS::MODSRDFVocabulary.relatedSucceeding, :class_name => "GenericFile"
  accepts_nested_attributes_for :related_succeeding
  
  # subject fields
  has_and_belongs_to_many :subject_topics, :predicate => MODS::MODSRDFVocabulary.subjectTopic, :class_name => "MODS::MADS::Topic"
  accepts_nested_attributes_for :subject_topics, allow_destroy: true
  
  has_and_belongs_to_many :subject_geographics, :predicate => MODS::MODSRDFVocabulary.subjectGeographic, :class_name => "MODS::MADS::Geographic"
  accepts_nested_attributes_for :subject_geographics, allow_destroy: true
  
  has_and_belongs_to_many :subject_temporals, :predicate => MODS::MODSRDFVocabulary.subjectTemporal, :class_name => "MODS::MADS::Temporal"
  accepts_nested_attributes_for :subject_temporals, allow_destroy: true
  
  has_and_belongs_to_many :subject_title, :predicate => MODS::MODSRDFVocabulary.subjectTitle, :class_name => "MODS::MADS::Title"
  accepts_nested_attributes_for :subject_title, allow_destroy: true
  
  has_and_belongs_to_many :subject_geographic_code, :predicate => MODS::MODSRDFVocabulary.subjectGeographicCode, :class_name => "MODS::MADS::GeographicCode"
  accepts_nested_attributes_for :subject_geographic_code, allow_destroy: true
  
  has_and_belongs_to_many :subject_hierarchical_geographic, :predicate => MODS::MODSRDFVocabulary.subjectHierarchicalGeographic, :class_name => "MODS::MADS::HierarchicalGeographic"
  accepts_nested_attributes_for :subject_hierarchical_geographic, allow_destroy: true
  
  has_and_belongs_to_many :cartographics, :predicate => MODS::MODSRDFVocabulary.cartographics, :class_name => "MODS::MADS::Cartographics"
  accepts_nested_attributes_for :cartographics, allow_destroy: true
  
  has_and_belongs_to_many :subject_occupations, :predicate => MODS::MODSRDFVocabulary.subjectOccupation, :class_name => "MODS::MADS::Occupation"
  accepts_nested_attributes_for :subject_occupations, allow_destroy: true
  
  has_and_belongs_to_many :subject_genres, :predicate => MODS::MODSRDFVocabulary.subjectGenre, :class_name => "MODS::MADS::GenreForm"
  accepts_nested_attributes_for :subject_genres, allow_destroy: true
  
  # table of contents
  property :table_of_contents, predicate: MODS::MODSRDFVocabulary.tableOfContents, multiple: true do |index|
     index.as :stored_searchable, :facetable
  end
  
  # target audience
  property :target_audience, predicate: MODS::MODSRDFVocabulary.targetAudience, multiple: true do |index|
     index.as :stored_searchable, :facetable
  end
  
  def save(arg = {})
    # self.title_principals.each do |ti|
      # ti.save! 
    # end
    # self.title_uniforms.each do |tu|
      # tu.save!
      # self.title_uniform_ids = self.title_uniform_ids + [tu.id] unless self.title_uniform_ids.include? tu.id
    # end
    # self.genres.each do |g|
      # g.save!
      # self.genre_ids = self.genre_ids + [g.id] unless self.genre_ids.include? g.id
    # end
    # self.subject_topics.each do |t|
      # t.save!
      # self.subject_topic_ids = self.subject_topic_ids + [t.id] unless self.subject_topic_ids.include? t.id
    # end
    # self.subject_geographics.each do |t|
      # t.save!
      # self.subject_geographic_ids = self.subject_geographic_ids + [t.id] unless self.subject_geographic_ids.include? t.id
    # end
    
    puts "saving +++++++++++++++++++"
    GenericFile.reflections.each do |assoc|
      assoc = assoc[1]
      if assoc.respond_to? :macro and assoc.macro == :has_and_belongs_to_many
        self.send(assoc.name).each do |assoc_elem|
          assoc_elem.save!
          self.send("#{assoc.name.to_s.singularize}_ids=", self.send("#{assoc.name.to_s.singularize}_ids") + [assoc_elem.id]) unless self.send("#{assoc.name.to_s.singularize}_ids").include? assoc_elem.id
        end
      end
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
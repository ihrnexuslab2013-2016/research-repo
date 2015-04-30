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
  
  def save(arg)
    self.title_principals.each do |ti|
      ti.save!
      #self.title_principle_ids += [ti.id]
    end
    self.title_uniforms.each do |tu|
      tu.save!
      #self.title_uniforms_ids += [tu.id]
    end
    super
  end
  
 
  
  # override inherited properties
  #property :resource_type, predicate: ::KarkinosRDF::MODS.type_of_resource do |index|
  #  index.as :stored_searchable, :facetable
  #end
  
  property :label, predicate: ActiveFedora::RDF::Fcrepo::Model.downloadFilename, multiple: false

  property :depositor, predicate: ::RDF::URI.new("http://id.loc.gov/vocabulary/relators/dpt"), multiple: false do |index|
    index.as :symbol, :stored_searchable
  end

  property :relative_path, predicate: ::RDF::URI.new('http://scholarsphere.psu.edu/ns#relativePath'), multiple: false

  property :import_url, predicate: ::RDF::URI.new('http://scholarsphere.psu.edu/ns#importUrl'), multiple: false do |index|
    index.as :symbol
  end

  property :part_of, predicate: ::RDF::DC.isPartOf
 
  #property :title, predicate: ::RDF::DC.title do |index|
  #  index.as :stored_searchable, :facetable
  #end
  property :creator, predicate: ::RDF::DC.creator do |index|
    index.as :stored_searchable, :facetable
  end
  property :contributor, predicate: ::RDF::DC.contributor do |index|
    index.as :stored_searchable, :facetable
  end
  property :description, predicate: ::RDF::DC.description do |index|
    index.type :text
    index.as :stored_searchable
  end
  property :tag, predicate: ::RDF::DC.relation do |index|
    index.as :stored_searchable, :facetable
  end
  property :rights, predicate: ::RDF::DC.rights do |index|
    index.as :stored_searchable
  end
  property :publisher, predicate: ::RDF::DC.publisher do |index|
    index.as :stored_searchable, :facetable
  end
  property :date_created, predicate: ::RDF::DC.created do |index|
    index.as :stored_searchable
  end

  # We reserve date_uploaded for the original creation date of the record.
  # For example, when migrating data from a fedora3 repo to fedora4,
  # fedora's system created date will reflect the date when the record
  # was created in fedora4, but the date_uploaded will preserve the
  # original creation date from the old repository.
  property :date_uploaded, predicate: ::RDF::DC.dateSubmitted, multiple: false do |index|
    index.type :date
    index.as :stored_sortable
  end

  property :date_modified, predicate: ::RDF::DC.modified, multiple: false do |index|
    index.type :date
    index.as :stored_sortable
  end
  property :subject, predicate: ::RDF::DC.subject do |index|
    index.as :stored_searchable, :facetable
  end
  property :language, predicate: ::RDF::DC.language do |index|
    index.as :stored_searchable, :facetable
  end
  property :identifier, predicate: ::RDF::DC.identifier do |index|
    index.as :stored_searchable
  end
  property :based_near, predicate: ::RDF::FOAF.based_near do |index|
    index.as :stored_searchable, :facetable
  end
  property :related_url, predicate: ::RDF::RDFS.seeAlso do |index|
    index.as :stored_searchable
  end
  property :bibliographic_citation, predicate: ::RDF::DC.bibliographicCitation do |index|
    index.as :stored_searchable
  end
  property :source, predicate: ::RDF::DC.source do |index|
    index.as :stored_searchable
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
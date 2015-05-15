class KarkinosGenericFilePresenter < Sufia::GenericFilePresenter
  include AttributeHelper
  
  attr_accessor :use_fields_map
  attr_accessor :datafile_presenters
  
  
  def initialize(object)
      super
        
      @use_fields_map = Hash.new
      uses = object.use
      uses.each do |use|
        get_use_fields_symbols use
      end
     
      @datafile_presenters = Hash.new
      object.data_files.each do |df|
        @datafile_presenters.store(df, DatafilePresenter.new(df))
      end
  end
  
  def uses=(uses)
      @use_fields_map = Hash.new
      
      uses.each do |use|
        get_use_fields_symbols use
      end
  end
  
  self.terms = [:resource_type, :title_principals, :title_uniforms, :abstract, :access_condition, :genres, :language_of_resource, :location_of_resources, :name_principals, :names, :notes, :statement_of_responsibility, :note_groups, :edition, :frequency, :date_issued, :parts, :form, :reformatting_quality, :media_type, :related_host, :related_referenced_by, :related_original, :related_format, :related_version, :related_preceding, :related_reference, :related_review, :related_series, :related_succeeding, :subject_topics, :subject_geographics, :subject_hierarchical_geographic, :cartographics, :subject_occupations, :subject_genres, :table_of_contents, :target_audience, :use ]
        
  @@nested_terms = []
  
  def nested_terms
    @@nested_terms
  end
      
  def self.datafile_terms 
    DatafilePresenter.terms
  end

end
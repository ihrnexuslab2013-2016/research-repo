class KarkinosGenericFilePresenter < Sufia::GenericFilePresenter
  include AttributeHelper
  
  self.terms = [:resource_type, :title_principals, :title_uniforms, :abstract, :access_condition, :genres, :language_of_resources, :location_of_resources, :names, :notes, :statement_of_responsibility, :note_groups, :edition, :frequency, :date_issued, :parts, :form, :reformatting_quality, :media_type, :related_hosts, :related_referenced_by, :related_originals, :related_formats, :related_versions, :related_precedings, :related_references, :related_reviews, :related_series, :related_succeedings, :subject_topics, :subject_geographics, :subject_temporals, :subject_hierarchical_geographics, :subject_titles, :subject_geographic_codes, :cartographics, :subject_occupations, :subject_genres, :table_of_contents, :target_audience, :use]
  @@always_present_terms = [:use]
  
  attr_accessor :use_fields_map
  attr_accessor :datafile_presenters
  attr_accessor :display_terms
  attr_accessor :always_present_terms
  
  
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
      
      @display_terms = PropertyProviderService.get_type_properties object.resource_type
      labels = self.class.terms.map {|t| {:label => t.to_s}}
      @display_terms = Hash[*self.class.terms.zip(labels).flatten.compact] if @display_terms.empty?
      #@display_terms = Hash[*@@always_present_terms.zip(@@always_present_terms).flatten.compact].merge(@display_terms)
  end
  
  def uses=(uses)
      @use_fields_map = Hash.new
      
      uses.each do |use|
        get_use_fields_symbols use
      end
  end
  
   
  def self.datafile_terms 
    DatafilePresenter.terms
  end

end
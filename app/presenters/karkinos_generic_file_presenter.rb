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
  
  self.terms = [:resource_type, :title_principals, :title_uniforms, :abstract, :accessCondition, :genres, :languageOfResource, :locationOfResources, :namePrincipals, :names, :notes, :statementOfResponsibility, :noteGroups, :edition, :frequency, :dateIssued, :parts, :form, :reformattingQuality, :mediaType, :relatedHost, :relatedReferencedBy, :relatedOriginal, :relatedFormat, :relatedVersion, :relatedPreceding, :relatedReference, :relatedReview, :relatedSeries, :relatedSucceeding, :subject_topics, :subject_geographics, :use ]
        
  @@nested_terms = []
  
  def nested_terms
    @@nested_terms
  end
      
  def self.datafile_terms 
    DatafilePresenter.terms
  end

end
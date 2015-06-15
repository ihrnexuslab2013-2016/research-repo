# -*- encoding : utf-8 -*-
class SolrDocument 

  include Blacklight::Solr::Document
  include Blacklight::Gallery::OpenseadragonSolrDocument

  # Adds Sufia behaviors to the SolrDocument.
  include Sufia::SolrDocumentBehavior


  # self.unique_key = 'id'
  
  # Email uses the semantic field mappings below to generate the body of an email.
  SolrDocument.use_extension( Blacklight::Document::Email )
  
  # SMS uses the semantic field mappings below to generate the body of an SMS email.
  SolrDocument.use_extension( Blacklight::Document::Sms )

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Document::SemanticFields#field_semantics
  # and Blacklight::Document::SemanticFields#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension( Blacklight::Document::DublinCore)    

  def subject_topics
    Array(self[Solrizer.solr_name("subject_topics")])
  end
  def title_principals
    Array(self[Solrizer.solr_name("title_principals")])
  end
  
  def title_or_label
    title_principals.first || title || label
  end
  
  def description
    Array(self[Solrizer.solr_name("notes")]).first
  end
end

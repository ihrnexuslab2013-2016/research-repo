module SolrObject
  extend ActiveSupport::Concern
  
   # we need to add the nested attributes to the generic file solr document
  # so that they can be found in the search
  # this is an adapted version of
  # https://github.com/ucsdlib/damspas/blob/develop/app/models/datastreams/dams_resource_datastream.rb
  # thank you UCSD
  def to_solr()
    solr_doc = super

    facetable = Solrizer::Descriptor.new(:string, :indexed, :multivalued)

    # title
    insert_title_fields solr_doc, nil, self.title_principals, 'title_principals'
    insert_title_fields solr_doc, nil, self.title_uniforms, 'title_uniforms'
    insert_fields solr_doc, self.genres, 'genres'
    insert_location_fields solr_doc, self.location_of_resources
    insert_name_fields solr_doc, self.names
    insert_parts_fields solr_doc, self.parts
    insert_note_group_fields solr_doc, self.note_groups
    
    # subjects
    insert_fields solr_doc, self.subject_topics, 'subject_topics'
    insert_fields solr_doc, self.subject_geographics, 'subject_geographics'
    insert_fields solr_doc, self.subject_temporals, 'subject_temporals'
    insert_title_fields solr_doc, nil, self.subject_titles, 'subject_title'
    insert_fields solr_doc, self.subject_geographic_codes, 'subject_geographic_code'
    insert_fields solr_doc, self.subject_hierarchical_geographics, 'subject_hierarchical_geographics'
    insert_fields solr_doc, self.cartographics, 'cartographics'
    insert_fields solr_doc, self.subject_occupations, 'subject_occupations'
    insert_fields solr_doc, self.subject_genres, 'subject_genres'

    solr_doc
  end
  
  def insert_fields (solr_doc, objects, fieldName)
    if objects != nil
      objects.each do |obj|
        Solrizer.insert_field(solr_doc, fieldName, obj.label)
        Solrizer.insert_field(solr_doc, "all_fields", obj.label)
      end
    end
    insert_facets(solr_doc, objects, fieldName)
  end
  
  def insert_note_group_fields(solr_doc, notegroups)
    if !notegroups.nil?
       facetable = Solrizer::Descriptor.new(:string, :indexed, :multivalued)
       notegroups.map do |note_group|
         note_json = {}
         note_json[:id] = note_group.id
         note_json.merge!( :note_group_note => note_group.note_group_note.to_s,
                         :note_group_type => note_group.note_group_type.to_s)
         Solrizer.insert_field(solr_doc, "note_groups_json", note_json.to_json )
        
         Solrizer.insert_field(solr_doc, 'note_group_type', note_group.note_group_type)
         Solrizer.insert_field(solr_doc, "all_fields", note_group.note_group_type)
         
         Solrizer.insert_field(solr_doc, 'note_group_note', note_group.note_group_note)
         Solrizer.insert_field(solr_doc, "all_fields", note_group.note_group_note)
        
        
         Solrizer.insert_field(solr_doc, 'note_group_type', note_group.note_group_type,facetable)
       end
    end
  end
  
  def insert_location_fields (solr_doc, locations) 
    if !locations.nil?
      facetable = Solrizer::Descriptor.new(:string, :indexed, :multivalued)
      locations.map do |loc_obj|
        loc_json = {}
        loc_json[:id] = loc_obj.id
        loc_json.merge!( :location_physical => loc_obj.location_physical.to_s,
                         :location_shelf_locator => loc_obj.location_shelf_locator.to_s)
          
        loc_json[:location_copies] = []       
        loc_obj.location_copies.each do |loc_copy|
          loc_json[:location_copies] << {:id => loc_copy.id, :location_copy_shelf_locator => loc_copy.location_copy_shelf_locator, :location_copy_enumeration_and_chronology_basic => loc_copy.location_copy_enumeration_and_chronology_basic}
        end
                         
        Solrizer.insert_field(solr_doc, "location_of_resources_json", loc_json.to_json )
        
        Solrizer.insert_field(solr_doc, 'location_physical', loc_obj.location_physical)
        Solrizer.insert_field(solr_doc, "all_fields", loc_obj.location_physical)
        
        Solrizer.insert_field(solr_doc, 'location_physical', loc_obj.location_physical,facetable)
      end
    end
  end
  
  def insert_parts_fields (solr_doc, parts)
    if !parts.nil?
      facetable = Solrizer::Descriptor.new(:string, :indexed, :multivalued)
      parts.map do |part|
        part_json = {}
        part_json[:id] = part.id
        part_json.merge!(:part_order => part.part_order, :part_level => part.part_level, :part_caption => part.part_caption, :part_number => part.part_number)
        
        Solrizer.insert_field(solr_doc, "parts_json", part_json.to_json )
        
        Solrizer.insert_field(solr_doc, 'parts', part.part_caption)
        Solrizer.insert_field(solr_doc, "all_fields", part.part_caption)
        
        Solrizer.insert_field(solr_doc, 'parts', part.part_level,facetable)
      end
    end
  end
  
  def insert_name_fields (solr_doc, names)
    if !names.nil?
      facetable = Solrizer::Descriptor.new(:string, :indexed, :multivalued)
      names.map do |name|
        name_json = {}
        name_json[:id] = name.id
        name_json.merge!(:label => name.label, :role => name.role, :relation => name.relation)
        
        Solrizer.insert_field(solr_doc, "names_json", name_json.to_json )
        
        Solrizer.insert_field(solr_doc, 'names', name.label)
        Solrizer.insert_field(solr_doc, "all_fields", name.label)
        Solrizer.insert_field(solr_doc, 'names', name.label, facetable)
        
        Solrizer.insert_field(solr_doc, 'names', name.role)
        Solrizer.insert_field(solr_doc, "all_fields", name.role)
        
        Solrizer.insert_field(solr_doc, 'names', name.role, facetable)
      end
    end
  end
  
  def insert_facets (solr_doc, objects, fieldName)
    facetable = Solrizer::Descriptor.new(:string, :indexed, :multivalued)
    if objects != nil
      objects.each do |obj|
        Solrizer.insert_field(solr_doc, fieldName, obj.label,facetable)
      end
    end
  end
  
  def insert_subject_fields( solr_doc, fieldName, objects )
    insert_fields solr_doc, fieldName, objects
    insert_facets solr_doc, objects, 'subject_topic'
  end
  
  # add solr fields for title attributes
  def insert_title_fields ( solr_doc, cid, titles, field_name )
    sort_title = ""
    titles.each do |t|
      begin
        title = t.label
        
        # structured
        title_json = { :title => title }
        if cid != nil
          Solrizer.insert_field(solr_doc, "component_#{cid}_#{field_name}_json", title_json.to_json)
        else
          Solrizer.insert_field(solr_doc, "#{field_name}_json", title_json.to_json)
        end

        # retrieval
        Solrizer.insert_field(solr_doc, field_name, title)
        Solrizer.insert_field(solr_doc, "all_fields", title)
      
        # build sort title
        if sort_title == "" && cid == nil
          sort_title = title
        end
      rescue Exception => e
        logger.warn "XXX insert_title_fields: #{e.to_s}"
      end
    end
    #insert_facets solr_doc, titles, field_name
        
  end
    
end
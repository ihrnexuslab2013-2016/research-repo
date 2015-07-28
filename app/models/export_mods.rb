module ExportMODS
    
  def export_as_mods_xml
    mods_xml = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
      xml.mods('xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance", "version" => "3.5", 'xsi:schemaLocation' => "http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-5.xsd") {
        add_mods_fields self,xml
        
        # related items
        related_hosts.each do |rel|
          xml.relatedItem(:type => "host") {
            add_mods_fields rel,xml
          }
        end
        related_referenced_by.each do |rel|
          xml.relatedItem(:type => "isReferencedBy") {
            add_mods_fields rel,xml
          }
        end
        related_originals.each do |rel|
          xml.relatedItem(:type => "original") {
            add_mods_fields rel,xml
          }
        end
        related_formats.each do |rel|
          xml.relatedItem(:type => "otherFormat") {
            add_mods_fields rel,xml
          }
        end
        related_versions.each do |rel|
          xml.relatedItem(:type => "otherVersion") {
            add_mods_fields rel,xml
          }
        end
        related_precedings.each do |rel|
          xml.relatedItem(:type => "preceding") {
            add_mods_fields rel,xml
          }
        end
        related_references.each do |rel|
          xml.relatedItem(:type => "references") {
            add_mods_fields rel,xml
          }
        end
        related_reviews.each do |rel|
          xml.relatedItem(:type => "reviewOf") {
            add_mods_fields rel,xml
          }
        end
        related_series.each do |rel|
          xml.relatedItem(:type => "series") {
            add_mods_fields rel,xml
          }
        end
        related_succeedings.each do |rel|
          xml.relatedItem(:type => "succeeding") {
            add_mods_fields rel,xml
          }
        end
        
      # end mods
      }
    end
    
    mods_xml.to_xml(indent: 3)
  end
  
  def add_mods_fields file, xml
    # add title principals
    file.title_principals.each do |title|
      xml.titleInfo {
        xml.title title.label
      }
    end
    
    # add title uniform
    file.title_uniforms.each do |title|
      xml.titleInfo(:type => 'uniform') {
        xml.title title.label
      }
    end
    
    # add abstract
    file.abstract.each do |abstract|
      xml.abstract abstract
    end
    
    # add access conditions
    file.access_condition.each do |cond|
      xml.accessCondition cond
    end
    
    # add genres
    file.genres.each do |genre|
      xml.genre genre.label
    end
    
    # add language
    file.language_of_resources.each do |lang|
      xml.language {
        xml.languageTerm(:type => "code", :authority => "iso639-2b"){ xml.text(lang) }
      }
    end
    
    # add locations
    file.location_of_resources.each do |loc|
      xml.location {
        if !loc.location_physical.nil? and !loc.location_physical.blank?
          xml.physicalLocation loc.location_physical
        end
        if !loc.location_shelf_locator.nil? and !loc.location_shelf_locator.blank?
          xml.shelfLocator loc.location_shelf_locator
        end
        if !loc.url.nil? and !loc.url.blank?
          xml.url loc.url
        end
      }
    end
    
    # add names
    # todo: add other properties
    file.names.each do |name|
      xml.name {
        xml.namePart name.label
      }
    end
    
    # add notes
    file.notes.each do |note|
      xml.note note
    end
    
    # add statement of responsibility
    file.statement_of_responsibility.each do |statement|
      xml.note(:type => "statement of responsibility") { xml.text(statement) }          
    end
    
    # add typed notes
    file.note_groups.each do |note|
      xml.note(:type => note.note_group_type) { xml.text(note.note_group_note) }
    end
    
    # add edition
    file.edition.each do |edition|
      xml.originInfo {
        xml.edition edition
      }
    end
    
    #add frequency
    file.frequency.each do |freq|
      xml.originInfo {
        xml.frequency freq
      }
    end
    
    file.date_issued.each do |date|
      xml.originInfo {
        xml.dateIssued date
      }
    end
    
    file.parts.each do |part|
      xml.part(:order => part.part_order) {
        xml.detail(:level => part.part_level) {
          xml.number part.part_number
          xml.caption part.part_caption
        }
      }
    end
    
    xml.physicalDescription {
      file.form.each do |f|
        xml.form f
      end
      file.reformatting_quality.each do |q|
        xml.reformattingQuality q
      end
      file.media_type.each do |m|
        xml.internetMediaType m
      end
      file.extent.each do |e|
        xml.extent e
      end
      file.digital_origin.each do |d|
        xml.digitalOrigin d
      end
    }
  end
end
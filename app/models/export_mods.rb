module ExportMODS
    
  def export_as_mods_xml
    mods_xml = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
      xml.mods(:version => "3.5", 'xsi:schemaLocation' => "http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-5.xsd") {
        # add title principals
        title_principals.each do |title|
          xml.titleInfo {
            xml.title title.label
          }
        end
        
        # add title uniform
        title_uniforms.each do |title|
          xml.titleInfo(:type => 'uniform') {
            xml.title title.label
          }
        end
        
        # add abstract
        abstract.each do |abstract|
          xml.abstract abstract
        end
        
        # add access conditions
        access_condition.each do |cond|
          xml.accessCondition cond
        end
        
        # add genres
        genres.each do |genre|
          xml.genre genre.label
        end
        
        # add language
        language_of_resources.each do |lang|
          xml.language {
            xml.languageTerm(:type => "code", :authority => "iso639-2b"){ xml.text(lang) }
          }
        end
        
        # add locations
        location_of_resources.each do |loc|
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
        names.each do |name|
          xml.name {
            xml.namePart name.label
          }
        end
        
        # add notes
        notes.each do |note|
          xml.note note
        end
        
        # add statement of responsibility
        statement_of_responsibility.each do |statement|
          xml.note(:type => "statement of responsibility") { xml.text(statement) }          
        end
        
        # add typed notes
        note_groups.each do |note|
          xml.note(:type => note.note_group_type) { xml.text(note.note_group_note) }
        end
        
        # add edition
        edition.each do |edition|
          xml.originInfo {
            xml.edition edition
          }
        end
        
        #add frequency
        frequency.each do |freq|
          xml.originInfo {
            xml.frequency freq
          }
        end
        
        date_issued.each do |date|
          xml.originInfo {
            xml.dateIssued date
          }
        end
        
        parts.each do |part|
          xml.part(:order => part.part_order) {
            xml.detail(:level => part.part_level) {
              xml.number part.part_number
              xml.caption part.part_caption
            }
          }
        end
        
      # end mods
      }
    end
    
    mods_xml.to_xml(indent: 3)
  end
end
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
      # end modsCollection
      }
    end
    
    mods_xml.to_xml(indent: 3)
  end
end
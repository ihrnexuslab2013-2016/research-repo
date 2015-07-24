module ExportMODS
    
  def export_as_mods_xml
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.modsCollection {
        
      }
    end
  end
end
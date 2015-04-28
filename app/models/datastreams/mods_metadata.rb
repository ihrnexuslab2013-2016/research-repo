class ModsMetadata < ActiveFedora::OmDatastream

  set_terminology do |t|
    t.root(path: "fields")#, :xmlns=>"http://www.loc.gov/mods/v3")
    #t.titleInfo(:path => "titleInfo") {
    #  t.title(:path => "title")
    #}
    t.author
    
    #t.titleInfo_title(:proxy => [:titleInfo, :title])
  end

  def self.xml_template
    Nokogiri::XML.parse("<fields/>")
  end

end
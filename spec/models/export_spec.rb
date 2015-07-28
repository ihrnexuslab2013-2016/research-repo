require 'rails_helper'

describe GenericFile do
  
  let(:file) do
    GenericFile.create.tap do |f|
      f.apply_depositor_metadata "user"
      f.save!
    end
  end
  
  describe "exporting to MODS XML" do
    before {
      file.title_principals_attributes = [{label: "First title"}]
      file.title_uniforms_attributes = [{label: "First uniform title"}]
      file.abstract = ["Test abstract with a few more words."]
      file.access_condition = ["Personal, noncommercial use of this item is permitted in the United States of America. Please see http://digital.library.upenn.edu/women/ for other rights and restrictions that may apply to this resource."]
      file.genres_attributes = [{label: "Web site"}]
      file.language_of_resources = ["eng"]
      file.location_of_resources_attributes = [{location_physical: "Indiana University, Bloomington. University Archives P07803", location_shelf_locator: "HB123.89" }, { url: "http://purl.dlib.indiana.edu/iudl/archives/cushman/P07803" }]
      file.names_attributes =[{label: "Raschke, Gregory K."}]
      file.notes = ["Dominus vo-bisque'em et come spear a tu-tu, oh."]
      file.statement_of_responsibility = ["created and maintained by the Asian Division, Area Studies Directorate"]
      file.note_groups_attributes = [{note_group_note: "Received: 6/17/82; ref print; gift, ATM 138; AFI/Woods (John) Collection.", note_group_type: "acquisition"}]
      file.edition = ["Limited ed"]
      file.frequency = ["Annual"]
      file.date_issued = ["1889"]
      file.parts_attributes = [{part_order: "2", part_level: "no. 3", part_caption: "Caption", part_number: "Part 1"}]
      file.form = ["graphic"]
      file.reformatting_quality = ["good"]
      file.media_type = ["text/html"]
      file.extent = ["1 slide : col. ; 35mm"]
      file.digital_origin = ["reformatted digital"]
      file.related_hosts_attributes = [{date_issued: ["1955-03-22"], form: ["graphic"], extent: ["1 slide : col. ; 35mm"],  location_of_resources_attributes: [{location_physical: "Indiana University, Bloomington. University Archives P07803"}]}]
      file.related_referenced_by_attributes = [{date_issued: ["1955-03-22"], form: ["graphic"], extent: ["1 slide : col. ; 35mm"],  location_of_resources_attributes: [{location_physical: "Indiana University, Bloomington. University Archives P07803"}]}]
      file.related_originals_attributes = [{date_issued: ["1955-03-22"], form: ["graphic"], extent: ["1 slide : col. ; 35mm"],  location_of_resources_attributes: [{location_physical: "Indiana University, Bloomington. University Archives P07803"}]}]
      file.related_formats_attributes = [{date_issued: ["1955-03-22"], form: ["graphic"], extent: ["1 slide : col. ; 35mm"],  location_of_resources_attributes: [{location_physical: "Indiana University, Bloomington. University Archives P07803"}]}]
      file.related_versions_attributes = [{date_issued: ["1955-03-22"], form: ["graphic"], extent: ["1 slide : col. ; 35mm"],  location_of_resources_attributes: [{location_physical: "Indiana University, Bloomington. University Archives P07803"}]}]
      file.related_precedings_attributes = [{date_issued: ["1955-03-22"], form: ["graphic"], extent: ["1 slide : col. ; 35mm"],  location_of_resources_attributes: [{location_physical: "Indiana University, Bloomington. University Archives P07803"}]}]
      file.related_references_attributes = [{date_issued: ["1955-03-22"], form: ["graphic"], extent: ["1 slide : col. ; 35mm"],  location_of_resources_attributes: [{location_physical: "Indiana University, Bloomington. University Archives P07803"}]}]
      file.related_reviews_attributes = [{date_issued: ["1955-03-22"], form: ["graphic"], extent: ["1 slide : col. ; 35mm"],  location_of_resources_attributes: [{location_physical: "Indiana University, Bloomington. University Archives P07803"}]}]
      file.related_series_attributes = [{date_issued: ["1955-03-22"], form: ["graphic"], extent: ["1 slide : col. ; 35mm"],  location_of_resources_attributes: [{location_physical: "Indiana University, Bloomington. University Archives P07803"}]}]
      file.related_succeedings_attributes = [{date_issued: ["1955-03-22"], form: ["graphic"], extent: ["1 slide : col. ; 35mm"],  location_of_resources_attributes: [{location_physical: "Indiana University, Bloomington. University Archives P07803"}]}]
    }
    subject(:xml){ file.export_as_mods_xml }
    it {
      file = File.open("#{Rails.root}/spec/models/mods.xml")
      xml = file.read
      is_expected.to eql xml
    }
    
  end
end
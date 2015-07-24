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
    }
    subject(:xml){ file.export_as_mods_xml }
    it {
      file = File.open("#{Rails.root}/spec/models/mods.xml")
      xml = file.read
      is_expected.to eql xml
    }
    
  end
end
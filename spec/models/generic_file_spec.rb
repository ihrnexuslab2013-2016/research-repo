require 'rails_helper'

describe GenericFile do

  let(:file) do
    GenericFile.create.tap do |f|
      f.apply_depositor_metadata "user"
      f.save!
    end
  end
  
  let(:related_file) do
    GenericFile.create.tap do |f|
      f.apply_depositor_metadata "user"
      f.save!
    end
  end

  describe "setting the title" do
    before { file.title = ["My Favorite Things"] }
    subject { file.title}
    it { is_expected.to eql ["My Favorite Things"] }
  end

  describe "adding a title principal" do
    before { file.title_principals_attributes = [{label: "First title"}] }
    subject(:title) { file.title_principals.first }
    it { 
      is_expected.to be_kind_of MODS::MADS::Title 
      expect(title.label).to eql "First title"
    }  
  end
  
  describe "adding a title uniform" do
    before { file.title_uniforms_attributes = [{label: "First uniform title"}] }
    subject(:title) { file.title_uniforms.first}
    it {
      is_expected.to be_kind_of MODS::MADS::Title
      expect(title.label).to eql "First uniform title"
    }
  end
  
  describe "adding an abstract" do
    before { file.abstract = ["First abstract"] }
    subject(:abstract) { file.abstract.first }
    it {
      is_expected.to eql "First abstract"
    }
  end
  
  describe "adding access condition" do
    before { file.access_condition = ["First access condition"] }
    subject(:access_cond) { file.access_condition.first }
    it {
      is_expected.to eql "First access condition"
    }
  end
  
  describe "adding a genre" do
    before { file.genres_attributes = [{ label: "First genre"}] }
    subject(:genre) { file.genres.first }
    it {
      is_expected.to be_kind_of MODS::Genre
      expect(genre.label).to eql "First genre"
    }
  end
  
  describe "adding a language of resources" do
    before { file.language_of_resources = [ "First language" ] }
    subject(:lor) { file.language_of_resources.first }
    it {
      is_expected.to eql "First language"
    }
  end
  
  describe "adding a location of a resource" do
    before { file.location_of_resources_attributes = [{ location_physical: "", location_shelf_locator: ""}, { location_physical: "First physical location", location_shelf_locator: "First shelf locator" }] }
    subject(:loc_of_res) { file.location_of_resources.first }
    it {
      is_expected.to be_kind_of MODS::Location
      expect(loc_of_res.location_physical).to eql "First physical location"
      expect(loc_of_res.location_shelf_locator).to eql "First shelf locator"
    }
  end
  
  describe "adding a name" do
    before { file.names_attributes = [ { label: ""}, { label: "First name with label", role: "director"}] }
    subject(:name) { file.names.first }
    it {
      is_expected.to be_kind_of MODS::MADS::Name
      expect(name.label).to eql "First name with label"
      expect(name.role).to eql "director"
    }
  end
  
  describe "adding a note" do
    before { file.notes = [ "First note" ] }
    subject(:note) { file.notes.first }
    it {
      is_expected.to eql "First note"
    }
  end
  
  describe "adding statement of responsibility" do
    before { file.statement_of_responsibility = ["First statement of responsibility"] }
    subject(:statement) { file.statement_of_responsibility.first }
    it {
      is_expected.to eql "First statement of responsibility"
    }
  end
  
  describe "adding a note group" do
    before { file.note_groups_attributes = [{ label: "First note group", note_group_type: "bibliography"}, {label: ""}] }
    subject(:note) { file.note_groups.first}
    it {
      is_expected.to be_kind_of MODS::NoteGroup
      expect(note.label).to eql "First note group"
      expect(note.note_group_type).to eql "bibliography"
      expect(file.note_groups.size).to eql 1
    }
  end
  
  describe "adding frequency" do 
    before { file.frequency = ["First frequency"] }
    subject(:frequency) { file.frequency.first }
    it {
      is_expected.to eql "First frequency"
    }
  end
  
  describe "adding edition" do
    before { file.edition = ["First edition"] }
    subject(:edition) { file.edition.first }
    it {
      is_expected.to eql "First edition"
    }
  end
  
  describe "adding date issued" do
    before { file.date_issued = ["First date issued"] }
    subject(:date) { file.date_issued.first }
    it {
      is_expected.to eql "First date issued"
    }
  end
  
  describe "adding a part" do
    before { file.parts_attributes = [{ part_order: ""}, { part_order: "1", part_level: "Level 1", part_caption: "Part caption", part_number: "Nr. 1"}] }
    subject(:part) { file.parts.first }
    it {
      is_expected.to be_kind_of MODS::Part
      expect(part.part_order).to eql "1"
      expect(part.part_level).to eql "Level 1"
      expect(part.part_caption).to eql "Part caption"
      expect(part.part_number).to eql "Nr. 1"
    }
  end
  
  describe "adding form" do
    before { file.form = ["First form"] }
    subject(:form) { file.form.first }
    it {
      is_expected.to eql "First form"
    }
  end
  
  describe "adding reformatting quality" do
    before { file.reformatting_quality = [ "First quality"] }
    subject(:quality) { file.reformatting_quality.first }
    it {
      is_expected.to eql "First quality"
    }
  end
  
  describe "adding media type" do
    before { file.media_type = ["First media type"] }
    subject(:media_type) { file.media_type.first }
    it {
      is_expected.to eql "First media type"
    }
  end
  
  # describe "adding related host" do
    # before { 
      # file.related_hosts_attributes = [{ id: related_file.id }] 
    # }
    # subject(:host) { file.related_hosts.first }
    # it {
      # is_expected.to be_kind_of GenericFile
      # expect(host.id).to eql related_file.id
    # }
  # end

end
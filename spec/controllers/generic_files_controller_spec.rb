require 'rails_helper'

describe GenericFilesController do
  routes { Sufia::Engine.routes }
  let(:user) { FactoryGirl.find_or_create(:user) }
  before do
    allow(controller).to receive(:has_access?).and_return(true)
    sign_in user
    allow_any_instance_of(User).to receive(:groups).and_return([])
    allow_any_instance_of(GenericFile).to receive(:characterize)
  end
  
  describe "update" do
    let(:generic_file) do
      GenericFile.create do |gf|
        gf.apply_depositor_metadata(user)
      end
    end

    before :each do
      @gen_file = generic_file
      @gen_file.title_principals = [MODS::MADS::Title.new]
      @gen_file.title_principals.first.save
      @gen_file.title_uniforms = [MODS::MADS::Title.new]
      @gen_file.title_uniforms.first.save
      
      # prepare genres
      @gen_file.genres = [MODS::Genre.new]
      @genre = @gen_file.genres.first
      @gen_file.genres.first.save
      
      # prepare locations
      @location = MODS::Location.new
      @gen_file.location_of_resources = [@location]
      @location.save!
      
      # prepare name
      @name = MODS::MADS::Name.new
      @name.role = "producer"
      @gen_file.names = [@name]
      @name.save!
      
      # prepare note group
      @note_group = MODS::NoteGroup.new
      @note_group.label ="note group"
      @note_group.note_group_type = "note type"
      @gen_file.note_groups = [@note_group]
      @note_group.save!
      
      # prepare parts
      @parts = MODS::Part.new
      @parts.part_order = "Order test"
      @parts.part_level = "Level"
      @gen_file.parts = [@parts]
      @parts.save!
      
      @gen_file.save!
    end

    context "when adding a title" do
      let(:attributes) { { title: ['My Favorite Things'] } }
      before { post :update, id: @gen_file, generic_file: attributes }
      subject do
        @gen_file.reload
        @gen_file.title.first
      end
      it { is_expected.to eql nil} #title is not permitted
    end

    context "when adding a title principal and a uniform title" do
      let(:attributes) do
        { 
          title_principals_attributes: {"0" => {label: 'Test Title', id: @gen_file.title_principals.first.id }},
          title_uniforms_attributes: {"0" => {label: 'Uniform title', id: @gen_file.title_uniforms.first.id} },
          permissions_attributes: [{ type: 'person', name: 'archivist1', access: 'edit'}]
        }
      end

      before { post :update, id: @gen_file, generic_file: attributes }
      subject { @gen_file.reload }

      it "sets the values using the parameters hash" do
        expect(subject.title_principals.first.label).to eql "Test Title"
        expect(subject.title_uniforms.first.label).to eql "Uniform title"
      end
    end
    
    context "when adding an abstract and access condition" do
      let(:attributes) do
        {
          abstract: ["First abstract"],
          access_condition: ["Access condition"]
        }
      end
      
      before {post :update, id: @gen_file, generic_file: attributes }
      subject { @gen_file.reload}
      
      it "sets the values using the parameter hash" do
        expect(subject.abstract.first).to eql "First abstract"
        expect(subject.access_condition.first).to eql "Access condition"
      end
    end
    
    context "when adding a genre" do
      let(:attributes) do
        {
          genres_attributes: {"0" => {label: "Test genre"}, "1" => {label: ""}, "2" => {label: "Updated genre", id: @gen_file.genres.first.id}}
        }
      end
      
      before { post :update, id: @gen_file, generic_file: attributes }
      subject { @gen_file.reload }
      
      it "adds genre without id, ignores empty labels, updates genre with id" do
        expect(subject.genres.size).to eql 2
        orig_genre = subject.genres.detect { |g| g.id == @genre.id }
        expect(orig_genre.label).to eql "Updated genre"
        new_genre = subject.genres.detect { |g| g.id != @genre.id }
        expect(new_genre.label).to eql "Test genre"
      end
    end
    
    context "when adding a location resource" do
      let(:attributes) do 
        {
          location_of_resources_attributes: { "0" => {location_physical: "New physical location", location_shelf_locator: "New shelf locator"}, "1" => {location_physical: ""}, "2" => {location_physical: "Updated physical location", location_shelf_locator: "Updated shelf locator", id: @location.id }}
        }
      end
      
      before { post :update, id: @gen_file, generic_file: attributes }
      subject { @gen_file.reload }
      
      it "adds a new location, ignores the empty location, updates the location that has an id" do
        expect(subject.location_of_resources.size).to eql 2
        
        orig_loc = subject.location_of_resources.detect { |g| g.id == @location.id }
        expect(orig_loc.location_physical).to eql "Updated physical location"
        expect(orig_loc.location_shelf_locator).to eql "Updated shelf locator"
        
        new_loc = subject.location_of_resources.detect { |g| g.id != @location.id }
        expect(new_loc.location_physical).to eql "New physical location"
        expect(new_loc.location_shelf_locator).to eql "New shelf locator"
      end
    end
    
    context "when adding and updating a name" do
      let(:attributes) do
        {
          names_attributes: {"0" => {role: "director", label: "New name"}, "1" => {label: ""}, "2" => {label: "Updated name", id: @name.id}}
        }
      end
      
      before { post :update, id: @gen_file, generic_file: attributes }
      subject { @gen_file.reload }
      
      it "adds a new name, ignores the empty name, updates the existing name" do
        expect(subject.names.size).to eql 2
        
        orig_name = subject.names.detect { |n| n.id == @name.id }
        expect(orig_name.label).to eql "Updated name"
        expect(orig_name.role).to eql "producer"
        
        new_name = subject.names.detect { |n| n.id != @name.id }
        expect(new_name.label).to eql "New name"
        expect(new_name.role).to eql "director"
      end
    end
    
    context "when adding a note" do
      let(:attributes) do
        {
          notes: ["First note"]
        }
      end
      
      before { post :update, id: @gen_file, generic_file: attributes }
      subject { @gen_file.reload }
      
      it "adds a new note" do
        expect(subject.notes.first).to eql "First note"
      end      
    end
    
    context "when adding a statement of responsibility" do
      let(:attributes) do
        {
          statement_of_responsibility: ["Statement"]
        }
      end
      
      before { post :update, id: @gen_file, generic_file: attributes}
      subject {@gen_file.reload }
      
      it "adds a new statement of responsibility" do
        expect(subject.statement_of_responsibility.first).to eql "Statement"
      end
    end
    
    context "when adding a new note group" do
      let(:attributes) do
        {
          note_groups_attributes: {"0" => {label: ""}, "1" => {note_group_type: "type"}, "2" => {label: "biblio", note_group_type: "bibliography"}, "3" => {label: "updated note", id: @note_group.id} }
        }
      end
      
      before { post :update, id: @gen_file, generic_file: attributes }
      subject { @gen_file.reload }
      
      it "adds a new note group" do
        expect(subject.note_groups.size).to eql 2
        
        orig_note = subject.note_groups.detect { |n| n.id == @note_group.id }
        expect(orig_note.label).to eql "updated note"
        expect(orig_note.note_group_type).to eql "note type"
        
        new_note = subject.note_groups.detect { |n| n.id != @note_group.id }
        expect(new_note.label).to eql "biblio"
        expect(new_note.note_group_type).to eql "bibliography"
      end
    end
    
    context "when adding edition, frequencey, and date issued" do
      let(:attributes) do
        {
          edition: ["edition test"],
          frequency: ["frequency test"],
          date_issued: ["date test"]
        }
      end
      
      before { post :update, id: @gen_file, generic_file: attributes }
      subject { @gen_file.reload }
      
      it "adds the attributes" do
        expect(subject.edition.first).to eql "edition test"
        expect(subject.frequency.first).to eql "frequency test"
        expect(subject.date_issued.first).to eql "date test"
      end
    end
    
    context "when adding parts" do
      let(:attributes) do
        {
          parts_attributes: { "0" => { part_order: ""}, "1" => { part_order: "Order", part_level: "Level", part_caption: "Caption", part_number: "Number"}, "2" => { part_level: "Level test", part_caption: "Caption test", id: @parts.id } }
        }
      end
      
      before { post :update, id: @gen_file, generic_file: attributes }
      subject { @gen_file.reload }
      
      it "adds a new part, and updates the other" do
        expect(subject.parts.size).to eql 2
        
        orig_part = subject.parts.detect { |n| n.id == @parts.id }
        expect(orig_part.part_order).to eql "Order test"
        expect(orig_part.part_level).to eql "Level test"
        expect(orig_part.part_caption).to eql "Caption test"
        expect(orig_part.part_number).to eql nil
        
        new_part = subject.parts.detect { |n| n.id != @parts.id }
        expect(new_part.part_order).to eql "Order"
        expect(new_part.part_level).to eql "Level"
        expect(new_part.part_caption).to eql "Caption"
        expect(new_part.part_number).to eql "Number"
      end
    end

  end

end
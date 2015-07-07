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

  end

end
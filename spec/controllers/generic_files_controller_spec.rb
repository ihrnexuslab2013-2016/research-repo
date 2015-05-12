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
      @gen_file.title_principals = [MODS::TitleInfo.new]
      @gen_file.title_principals.first.save
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

    context "when adding a title principal" do
      let(:attributes) do
        { 
          title_principals_attributes: {"0" => {label: 'Test Title', id: @gen_file.title_principals.first.id }},
          permissions_attributes: [{ type: 'person', name: 'archivist1', access: 'edit'}]
        }
      end

      before { post :update, id: @gen_file, generic_file: attributes }
      subject { @gen_file.reload }

      it "sets the values using the parameters hash" do
        expect(subject.title_principals.first.label).to eql "Test Title"
      end
    end

  end

end
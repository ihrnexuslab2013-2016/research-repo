require 'rails_helper'

describe GenericFile do

  let(:file) do
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

end
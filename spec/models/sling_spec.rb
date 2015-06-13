require 'rails_helper'

RSpec.describe Sling, type: :model do
  subject(:sling) { FactoryGirl.build :sling }
  it { should belong_to(:brand) }
  it "has a valid factory" do
    expect(FactoryGirl.build(:sling)).to be_valid
  end
  it "is invalid without a name" do
    expect(FactoryGirl.build(:sling, name: nil)).not_to be_valid
  end
  describe "#color_list" do
    it "returns normalized colors in a list" do
      sling = FactoryGirl.build(:sling, colors: "Light Blue, red, green")
      expect(sling.color_list).to eq ['light blue', 'red', 'green']
    end
    context "if empty" do
      it "returns an empty list" do
        sling = FactoryGirl.build(:sling, colors: nil)
        expect(sling.color_list).to eq []
      end
    end
  end

end

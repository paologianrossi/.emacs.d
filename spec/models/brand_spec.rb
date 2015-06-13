require 'rails_helper'

RSpec.describe Brand, type: :model do
  subject(:brand) { FactoryGirl.build(:brand) }
  it { should respond_to :name }
  it { should respond_to :website }

  it "is invalid without a name" do
    expect(FactoryGirl.build(:brand, name: nil)).not_to be_valid
  end

  it "is invalid without a website" do
    expect(FactoryGirl.build(:brand, website: nil)).not_to be_valid
  end

  it "is invalid with a bad URL" do
    expect(FactoryGirl.build(:brand, website: "htp://w.fo.b")).not_to be_valid
  end

  it "is invalid with a duplicate name" do
    dup = brand.dup
    dup.website = "http://www.foobar.com"
    dup.save
    expect(brand).not_to be_valid
  end

  it "is invalid with a duplicate URL" do
    dup = brand.dup
    dup.name = "foobar"
    dup.save
    expect(brand).not_to be_valid
  end

  it "fixes oddly capitalized URLs" do
    expect(FactoryGirl.build(:brand, website: "HttP://WWW.FOOBar.coM")).to be_valid
  end
end

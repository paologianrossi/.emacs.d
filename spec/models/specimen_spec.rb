require 'rails_helper'

RSpec.describe Specimen, type: :model do
  subject(:specimen) { FactoryGirl.build(:specimen) }
  it { should be_valid }
  it { should respond_to :size }
  it { should respond_to :actual_size }
  context "when missing sling" do
    before { specimen.sling = nil }
    it { should_not be_valid }
  end

  context "when missing user" do
    before { specimen.user = nil }
    it { should_not be_valid }
  end

  it "should allow multiple specimens for user/sling" do
    other = specimen.dup
    other.save
    expect(specimen).to be_valid
    expect { specimen.save }.to change(Specimen, :count).by(1)
  end

end

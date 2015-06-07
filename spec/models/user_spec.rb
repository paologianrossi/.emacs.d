require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { FactoryGirl::create(:user) }
  it { should respond_to :name }
  it { should respond_to :first_name }
  it { should respond_to :last_name }
  it { should respond_to :email }
  it { should respond_to :provider }
  it { should respond_to :gender }

  describe "#email" do
    context "when it is a valid email address" do
      before { user.email = "foo@example.com" }
      it { should be_valid }
    end
    context "when passed a bad email address" do
      before { user.email = "foo@example,com" }
      it { should_not be_valid }
    end
    context "when no email is present" do
      before { user.email = " " }
      it { should_not be_valid }
    end
  end

  describe "#gender" do
    context "when it is 'male'" do
      before { user.gender = 'male' }
      it { should be_valid }
      it { should be_male }
      it { should_not be_female }
    end
    context "when it is 'female'" do
      before { user.gender = 'female' }
      it { should be_valid }
      it { should_not be_male }
      it { should be_female }
    end
    context "when it is neither" do
      before { user.gender = 'foobar' }
      it { should_not be_valid }
      it { should_not be_male }
      it { should_not be_female }
    end
    context "when it is missing" do
      before { user.gender = " "}
      it { should be_valid }
      it { should_not be_male }
      it { should_not be_female }
    end
  end
end

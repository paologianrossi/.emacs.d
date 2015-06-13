require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { FactoryGirl::build(:user) }
  fields = [:provider, :uid, :first_name, :last_name, :name, :email,
            :image_url, :gender, :link, :locale, :significant_other]

  fields.each do |f|
    it { should respond_to f }
  end

  it "is invalid with a bad email" do
    expect(FactoryGirl.build(:user, email: "foo@example,com")).not_to be_valid
  end
  it "is invalid with no email" do
    expect(FactoryGirl.build(:user, email: nil)).not_to be_valid
  end

  describe ".from_omniauth" do
    subject(:user) { User.from_omniauth(mock_auth) }

    it "creates a user from an auth object" do
      expect(user).to be_a User
    end

  end

  describe "#gender" do
    context "when it is 'male'" do
      subject { FactoryGirl.build(:user, gender: 'male') }
      it { should be_valid }
      it { should be_male }
      it { should_not be_female }
    end
    context "when it is 'female'" do
      subject { FactoryGirl.build(:user, gender: 'female') }
      it { should be_valid }
      it { should_not be_male }
      it { should be_female }
    end
    context "when it is neither" do
      subject { FactoryGirl.build(:user, gender: 'foobar') }
      it { should_not be_valid }
      it { should_not be_male }
      it { should_not be_female }
    end
    context "when it is missing" do
      subject { FactoryGirl.build(:user, gender: nil) }
      it { should be_valid }
      it { should_not be_male }
      it { should_not be_female }
    end
  end

  describe "#significant_other" do
    context "with no significant_other_uid" do
      it "should be nil" do
        user = FactoryGirl.build(:user, significant_other_uid: nil)
        expect(user.significant_other).to be_nil
      end
    end
    context "with an unknown significant_other_uid" do
      it "should be nil" do
        user = FactoryGirl.build(:user, significant_other_uid: 99999)
        expect(user.significant_other).to be_nil
      end
    end
    context "with a valid significant_other_uid" do
      it "should be the pointed user" do
        other = FactoryGirl.create(:user, uid: 12345)
        user = FactoryGirl.build(:user, significant_other_uid: other.uid)
        expect(user.significant_other).to eq other
      end
    end
  end
end

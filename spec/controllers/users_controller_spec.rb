require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:user) { FactoryGirl.build(:user) }
  before {allow(controller).to receive(:current_user) { user }}

  describe "GET #index" do
    before { user.save }
    it "assigns all users to @users" do
      get :index
      expect(assigns(:users)).to eq [user]
    end
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    before do
      user.save
      get :show, id: user.id
      end
    it "assigns @user" do
      expect(assigns(:user)).to eq user
    end
    it "renders show" do
      expect(response).to render_template("show")
    end
  end

  describe "GET #edit" do
    before do
      user.save
      get :edit, id: user.id
      end
    it "assigns @user" do
      expect(assigns(:user)).to eq user
    end
    it "renders edit" do
      expect(response).to render_template("edit")
    end
    context "when editing not the authenticated user" do
      it "redirects to /" do
        other_user = FactoryGirl.create(:user)
        get :edit, id: other_user.id
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "POST #create" do
    context "when params are valid for a user" do
      it "creates a user" do
        expect{post :create, user: FactoryGirl.attributes_for(:user)}.to change(User, :count).by(1)
      end
      it "redirects to the user show path" do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to User.last
      end
    end
    context "when params are not valid for a user" do
      it "does not create the user" do
        expect{post :create, user: FactoryGirl.attributes_for(:user, email: "foobar")}.not_to change(User, :count)
      end
      it "renders #new" do
        post :create, user: FactoryGirl.attributes_for(:user, email: "foobar")
        expect(response).to render_template :new
      end
    end
  end
end

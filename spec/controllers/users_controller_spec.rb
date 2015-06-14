require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  before {allow(controller).to receive(:current_user) { user }}
  describe "GET #index" do
    before { get :index }
    it "assigns all users to @users" do
      expect(assigns(:users)).to eq [user]
    end
    it "renders the index template" do
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    before { get :show, id: user.id }
    it "assigns @user" do
      expect(assigns(:user)).to eq user
    end
    it "renders show" do
      expect(response).to render_template("show")
    end
  end

  describe "GET #edit" do
    before { get :edit, id: user.id }
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

  describe
end

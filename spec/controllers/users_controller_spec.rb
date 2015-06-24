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

  describe "PUT #update" do
    let(:user) { FactoryGirl.create(:user) }

    context "when the same user is authenticated" do
      before { allow(controller).to receive(:current_user) { user } }

      context "with valid attributes" do
        before { put :update, id: user.id, user: FactoryGirl.attributes_for(:user, name: "Long John Silver") }
        it "locates the requested user" do
          expect(assigns(:user)).to eq user
        end
        it "changes the user's attributes" do
          user.reload
          expect(user.name).to eq "Long John Silver"
        end
        it "redirects to the changed user" do
          expect(response).to redirect_to user
        end
      end

      context "with invalid attributes" do
        before { put :update, id: user.id, user: FactoryGirl.attributes_for(:user, email: "foobar") }
        it "locates the requested user" do
          expect(assigns(:user)).to eq user
        end
        it "does not change the user's attributes" do
          user.reload
          expect(user.email).not_to eq "foobar"
        end
        it "renders again the edit view" do
          expect(response).to render_template :edit
        end
      end
    end

    context "when the user is not authenticated" do
      before { allow(controller).to receive(:current_user).and_return(nil) }
      it "redirects to /" do
        put :update, id: user.id, user: FactoryGirl.attributes_for(:user, name: "John Doe")
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "DELETE #destroy" do
    let(:user) { FactoryGirl.create(:user) }
    context "when the same user is authenticated" do
      before { allow(controller).to receive(:current_user).and_return(user) }
      it "deletes the contact" do
        expect { delete :destroy, id: user.id }.to change(User, :count).by(-1)
      end
      it "redirects to logging out" do
        delete :destroy, id: user.id
        expect(response).to redirect_to signout_path
      end
    end
    context "when the user is not authenticated" do
      before { allow(controller).to receive(:current_user).and_return(nil) }
      it "redirects to /" do
        delete :destroy, id: user.id
        expect(response).to redirect_to root_path
      end
    end
  end

end

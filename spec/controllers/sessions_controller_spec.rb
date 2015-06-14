require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET #new" do
    it "redirects to /auth/facebook" do
      get :new
      expect(response).to redirect_to "/auth/facebook"
    end
  end

  describe "GET #create" do
    before do
      request.env['omniauth.auth'] = auth_mock
      get :create, provider: 'facebook'
    end
    it "sets up session with the authenticated user" do
      expect(session[:user_id]).not_to be_nil
    end
    it "redirects to /" do
      expect(response).to redirect_to root_path
    end
  end

  describe "GET #destroy" do
    before { session[:user_id] = 1234 }
    before { get :destroy }
    it "deletes the session" do
      expect(session[:user_id]).to be_nil
    end
    it "redirects to /" do
      expect(response).to redirect_to root_path
    end
    it "sets a notice" do
      expect(flash[:notice]).to be_present
    end
  end

  describe "GET #failure" do
    before { get :failure }
    it "redirects to /" do
      expect(response).to redirect_to root_path
    end
    it "sets an error message" do
      expect(flash[:alert]).to be_present
    end
  end
end

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
      get "create"
    end
    xit "sets up session with the authenticated user" do
      expect(session[:user_id]).not_to be_nil
    end
    xit "redirects to /" do
      expect(response).to redirect_to root_path
    end
  end
end

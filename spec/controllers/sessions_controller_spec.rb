require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
  before do
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  describe "POST create" do
    
    context "when user is logging for the first time" do

      it "should successfully create a user" do
        expect {
          post :create, :provider => :facebook
        }.to change { User.count }.by(1)
      end

      it "calls login! with given @user" do
        user_one = FactoryGirl.create(:user)
        expect(controller).to receive(:login!).with(user_one)
        post :create, {}, {}
      end

      it "should succesfully create a session" do
        expect(session[:user_id]).to eq(nil)
        post :create, :provider => :facebook
        expect(session[:user_id]).not_to eq(nil)
      end

      it "redirect to kitchens_path" do
        post :create, {}
        expect(response).to redirect_to(kitchens_path)
      end
    end

    context "when user information already exist in database" do

      it "does not create a new user" do
        user_one = User.create_with_omniauth(request.env["omniauth.auth"])
        user_one.save
        expect {
          post :create, :provider => :facebook
        }.to change { User.count }.by(0)
      end

      it "should succesfully create a session" do
        expect(session[:user_id]).to eq(nil)
        post :create, :provider => :facebook
        expect(session[:user_id]).not_to eq(nil)
      end

      it "redirect to kitchens_path" do
        post :create, {}
        expect(response).to redirect_to(kitchens_path)
      end
    end
  end

  describe "GET destroy" do

    context "when user is logged in " do
      before do
        post :create, :provider => :facebook
      end

      it "logs the user out" do
        expect(controller).to receive(:logout!)
        get :destroy, {}, {}
      end

      it "redirect back to root_url" do
        get :destroy, {}, {}
        expect(response).to redirect_to(root_url)
      end

      it "clear the session" do
        expect(session[:user_id]).not_to eq(nil)
        get :destroy, {}, {}
        expect(session[:user_id]).to eq(nil)
      end
    end
  end
end

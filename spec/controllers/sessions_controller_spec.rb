require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
  let(:email)     { "test@gmail.com" }
  let(:password)  { "abcd12345" }
  let(:nickname)  { "mynickname" }
  let(:valid_credentials) { { :email => email, :password => password, :nickname => nickname } }

  let!(:user) { FactoryGirl.create(:user, valid_credentials) }

  describe "POST create" do
    context "with valid credentials" do
      let(:credentials) { valid_credentials }

      it "calls login! with given user" do
        expect(controller).to receive(:login!).with(user)
        post :create, { :session => credentials }, {}
      end

      it "redirect to users_path" do
        post :create, { :session => credentials }
        expect(response).to redirect_to(users_path)
      end
    end

    context "with invalid email" do
      let(:credentials) { { :email => "wrongemail@gmail.com", :password => "1234", :nickname => "dj" } }

      it "does not call login!" do
        expect(controller).to_not receive(:login!)
        post :create, { :session => credentials }, {}
      end

      it "redirect back to root_url" do
        post :create, { :session => credentials }, {}
        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe "GET destroy" do
    context "when user is logged in " do
      it "logs the user out" do
        expect(controller).to receive(:logout!)
        get :destroy, {}, :user_id => user.id
      end

      it "redirect back to root_url" do
        get :destroy, {}, :user_id => user.id
        expect(response).to redirect_to(root_url)
      end
    end

    context "when user is logged out" do
      it "does not try to log the user out" do
        expect(controller).to_not receive(:logout!)
        get :destroy, {}, {}
      end

      it "redirects back to root_url" do
        get :destroy, {}, {}
        expect(response).to redirect_to(root_url)
      end
    end
  end
end

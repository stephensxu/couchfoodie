require 'rails_helper'

RSpec.describe KitchensController, :type => :controller do

  let(:valid_attributes) do
    FactoryGirl.attributes_for(:kitchen)
  end

  describe "DELETE destroy" do
    let!(:kitchen) { FactoryGirl.create(:kitchen_with_user) }

    context "the user created the requested kitchen" do
      it "change the data_status of kitchen to archive" do
        expect {
          delete :destroy, { :id => kitchen.id }, { :user_id => kitchen.user.id }
        }.to change{ kitchen.reload.data_status }.to("archive")
      end

      it "does not remove the kitchen record from database" do
        expect {
          delete :destroy, { :id => kitchen.id }, { :user_id => kitchen.user.id }
        }.to_not change(Kitchen, :count)
      end
    end
  end
end

# == Schema Information
#
# Table name: kitchens
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  description    :text             not null
#  street_address :string(255)      not null
#  city           :string(255)      not null
#  state          :string(255)      not null
#  zipcode        :string(255)      not null
#  latitude       :float
#  longtitude     :float
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer          not null
#  data_status    :string(255)      default("active"), not null
#
# Indexes
#
#  index_kitchens_on_user_id  (user_id)




require 'rails_helper'

RSpec.describe Kitchen, :type => :model do
  it { should have_many(:reservations) }
  it { should belong_to(:user) }

  describe "#valid?" do
    it { should validate_presence_of(:name) }
    it { should ensure_length_of(:name).is_at_least(6).is_at_most(50) }
    it { should allow_value("myktichen123", "someone's kitchen").for(:name) }
    it { should_not allow_value("@123").for(:name) }
    it { should_not allow_value("1234t").for(:name) }

    it { should validate_presence_of(:description) }
    it { should ensure_length_of(:description).is_at_least(10).is_at_most(250) }

    it { should validate_presence_of(:user) }

    it { should validate_presence_of(:street_address) }
    it { should ensure_length_of(:street_address).is_at_least(6).is_at_most(50) }

    it { should validate_presence_of(:city) }
    it { should ensure_length_of(:city).is_at_least(3).is_at_most(20) }

    it { should validate_presence_of(:state) }
    it { should ensure_length_of(:state).is_equal_to(2) }
    it { should allow_value("CA").for(:state) }
    it { should_not allow_value("CAE").for(:state) }
    it { should_not allow_value("12").for(:state) }

    it { should validate_presence_of(:zipcode) }
    it { should ensure_length_of(:zipcode).is_at_least(5) }
    it { should allow_value("95134", "12345-0934", "83592").for(:zipcode) }

    %w(1234 123456 12345-12345).each do |bad_zip|
      it { should_not allow_value(bad_zip).for(:zipcode) }
    end

    it { should validate_presence_of(:data_status) }
    it { should allow_value("active", "archive").for(:data_status) }
    it { should_not allow_value("somethig").for(:data_status) }
    it { should_not allow_value("123").for(:data_status) }
  end

  describe "kitchen" do
    describe "validation for uniqueness" do
      subject { FactoryGirl.create(:kitchen) }
      it { should validate_uniqueness_of(:name) }
    end

    describe "#editable_by?" do
      let(:kitchen) { FactoryGirl.create(:kitchen) }
      let(:other_user) { FactoryGirl.build_stubbed(:kitchen_with_user) }
      it "returns true when the owner created the kitchen" do
        expect(kitchen).to be_editable_by(kitchen.user)
      end

      it "returns false for user who did not create the kitchen" do
        expect(kitchen).to_not be_editable_by(other_user)
      end

      it "returns false for an anonymous user" do
        expect(kitchen).to_not be_editable_by(nil)
      end
    end

    describe "#editable?" do
      let(:kitchen) { FactoryGirl.create(:kitchen) }

      it "returns true when the data_status is active" do
        kitchen.data_status = "active"
        expect(kitchen).to be_editable
      end

      it "returns false when data_status is archive" do
        kitchen.data_status = "archive"
        expect(kitchen).to_not be_editable
      end
    end

    describe "#archive!" do
      let(:kitchen) { FactoryGirl.create(:kitchen) }
      it "change the data_status of kitchen to archive" do
        expect {
          kitchen.archive!
        }.to change{ kitchen.reload.data_status }.to eq("archive")
      end
    end
  end
end

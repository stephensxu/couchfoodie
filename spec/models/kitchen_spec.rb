# == Schema Information
#
# Table name: kitchens
#
#  id                  :integer          not null, primary key
#  name                :string(255)      not null
#  description         :text
#  street_address      :string(255)      not null
#  city                :string(255)      not null
#  state               :string(255)      not null
#  zipcode             :string(255)      not null
#  latitude            :float
#  longtitude          :float
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :integer          not null
#  data_status         :string(255)      default("active"), not null
#  front_page_photo_id :integer
#  menu                :string(255)      not null
#
# Indexes
#
#  index_kitchens_on_front_page_photo_id  (front_page_photo_id)
#  index_kitchens_on_user_id              (user_id)
#


require 'rails_helper'

RSpec.describe Kitchen, :type => :model do

  ### association test
  
  
  it { should belong_to(:user) }
  it { should belong_to(:front_page_photo) }

  it { should have_many(:reservations) }
  it { should have_many(:photos) }
  it { should have_many(:active_pending_reservations) }
  it { should have_many(:in_future_pending_reservations) }
  it { should have_many(:processed_photos) }
  it { should have_many(:unprocessed_photos) }


  ### validation test


  describe "#valid?" do

    it { should validate_presence_of(:name) }
    it { should ensure_length_of(:name).is_at_least(6).is_at_most(50) }
    it { should allow_value("myktichen123", "someone's kitchen").for(:name) }
    it { should_not allow_value("@123").for(:name) }
    it { should_not allow_value("1234t").for(:name) }

    it { should validate_presence_of(:menu) }
    it { should ensure_length_of(:menu).is_at_least(5).is_at_most(250) }

    it { should ensure_length_of(:description).is_at_most(250) }

    it { should validate_presence_of(:street_address) }
    it { should ensure_length_of(:street_address).is_at_least(6).is_at_most(50) }

    it { should validate_presence_of(:city) }
    it { should ensure_length_of(:city).is_at_least(3).is_at_most(50) }

    it { should validate_presence_of(:state) }
    it { should ensure_length_of(:state).is_equal_to(2) }
    it { should ensure_inclusion_of(:state).in_array(Kitchen::VALID_STATES) }
    it { should_not allow_value("CAE").for(:state) }
    it { should_not allow_value("12").for(:state) }

    it { should validate_presence_of(:zipcode) }
    it { should ensure_length_of(:zipcode).is_at_least(5) }
    it { should allow_value("95134", "12345-0934", "83592").for(:zipcode) }


    %w(1234 123456 12345-12345).each do |bad_zip|
      it { should_not allow_value(bad_zip).for(:zipcode) }
    end

    it { should validate_presence_of(:data_status) }
    it { should ensure_inclusion_of(:data_status).in_array(%w(active archive))}
    it { should_not allow_value("somethig").for(:data_status) }
    it { should_not allow_value("123").for(:data_status) }

    it { should validate_presence_of(:user) }

  end

  ### scope test
  

  describe "kitchen scope" do
    describe "scope :for_user" do
      let(:kitchen) { FactoryGirl.create(:kitchen) }
      let(:other_user) { FactoryGirl.create(:user) }
      it "returns the all the kitchens created by a certain user" do
        user_kitchens = Kitchen.for_user(kitchen.user)
        expect(user_kitchens).to include(kitchen)
      end

      it "does not return kitchen that's created by a different user" do
        other_kitchens = Kitchen.for_user(other_user)
        expect(other_kitchens).not_to include(kitchen)
      end
    end

    describe "scope :active" do
      let(:kitchen_one) { FactoryGirl.create(:kitchen, :data_status => "active") }
      let(:kitchen_two) { FactoryGirl.create(:kitchen, :data_status => "archive") }
      it "include kitchen record with data_status equals to active" do
        active_kitchens = Kitchen.active
        expect(active_kitchens).to include(kitchen_one)
      end

      it "does not include kitchen record with data_status equals to archive" do
        active_kitchens = Kitchen.active
        expect(active_kitchens).not_to include(kitchen_two)
      end
    end

    describe "scope :with_photo" do
      let(:photo_one) { FactoryGirl.create(:photo) }
      let(:kitchen_one) { FactoryGirl.create(:kitchen, :front_page_photo => photo_one) }
      let(:kitchen_two) { FactoryGirl.create(:kitchen, :front_page_photo => nil)}
      it "include kitchen that has a front page photo" do
        kitchens_with_photo = Kitchen.with_photo
        expect(kitchens_with_photo).to include(kitchen_one)
      end

      it "does not include kitchen that has no front page photo" do
        kitchens_with_photo = Kitchen.with_photo
        expect(kitchens_with_photo).not_to include(kitchen_two)
      end
    end

    describe "scope :published" do
      let(:photo_one) { FactoryGirl.create(:photo) }
      let(:kitchen_one) { FactoryGirl.create(:kitchen, :front_page_photo => photo_one, :data_status => "active") }
      let(:kitchen_two) { FactoryGirl.create(:kitchen, :front_page_photo => photo_one, :data_status => "archive") }
      let(:kitchen_three) { FactoryGirl.create(:kitchen, :front_page_photo => nil, :data_status => "active") }
      let(:kitchen_four) { FactoryGirl.create(:kitchen, :front_page_photo => nil, :data_status => "archive") }

      it "include kitchen that is both active and with photo" do
        kitchens_published = Kitchen.published
        expect(kitchens_published).to include(kitchen_one)
      end

      it "does not include kitchen that has photo but with archive data_status" do
        kitchens_published = Kitchen.published
        expect(kitchens_published).not_to include(kitchen_two)
      end

      it "does not include kitchen that is active but has no photo" do
        kitchens_published = Kitchen.published
        expect(kitchens_published).not_to include(kitchen_three)
      end

      it "does not include kitchen that is archived and has no photo" do
        kitchens_published = Kitchen.published
        expect(kitchens_published).not_to include(kitchen_four)
      end
    end
  end

  ### method test


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

    describe "#archived?" do
      let(:kitchen) { FactoryGirl.create(:kitchen) }

      it "returns false when the data_status is active" do
        kitchen.data_status = "active"
        expect(kitchen.reload.archived?).to be_falsey
      end

      it "returns true when data_status is archive" do
        kitchen.archive!
        expect(kitchen.reload.archived?).to be_truthy
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

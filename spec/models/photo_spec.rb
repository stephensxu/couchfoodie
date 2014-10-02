# == Schema Information
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  picture            :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  kitchen_id         :integer          not null
#  picture_tmp        :string(255)
#  processed_at       :datetime
#  picture_processing :boolean          default(FALSE), not null
#
# Indexes
#
#  index_photos_on_kitchen_id  (kitchen_id)
#


require 'rails_helper'

RSpec.describe Photo, :type => :model do

  ### Association tests

  it { should belong_to(:kitchen) }
  it { should have_one(:kitchen_displaying_as_front_page) }

  describe "#valid?" do

    it { should validate_presence_of(:picture) }
    it { should validate_presence_of(:kitchen) }

  end

  ### scope test
  
  describe "photo scope" do
    let(:photo_one) { FactoryGirl.create(:photo, :processed_at => Time.now) }
    let(:photo_two) { FactoryGirl.create(:photo, :processed_at => nil) }
    describe "scope :processed" do
      it "returns the photos when processed_at attribute is set to some value" do
        expect(Photo.processed).to include(photo_one)
      end

      it "does not return the photo when processed_at attribute is nil" do
        expect(Photo.processed).not_to include(photo_two)
      end
    end

    describe "scope :unprocessed" do
      it "returns the photos when processed_at attribute is nil" do
        expect(Photo.unprocessed).to include(photo_two)
      end

      it "does not return the photo when processed_at attribute is set to some value" do
        expect(Photo.unprocessed).not_to include(photo_one)
      end
    end
  end

  ### method tests

  describe "#set_as_front_page_photo_if_first" do
    it "sets the photo as front page photo of the kitchen if it's the first photo" do
      kitchen_one = FactoryGirl.create(:kitchen, :front_page_photo => nil)
      photo_one = FactoryGirl.create(:photo, :processed_at => Time.now, :kitchen => kitchen_one)
      photo_one.set_as_front_page_photo_if_first
      expect(kitchen_one.reload.front_page_photo).to eq(photo_one)
    end

    it "does not set the photo as front page photo if front_page_photo already exists" do
      kitchen_one = FactoryGirl.create(:kitchen, :front_page_photo => nil)
      photo_one = FactoryGirl.create(:photo, :processed_at => Time.now, :kitchen => kitchen_one)
      photo_two = FactoryGirl.create(:photo, :processed_at => Time.now, :kitchen => kitchen_one)
      photo_one.set_as_front_page_photo_if_first
      photo_one.set_as_front_page_photo_if_first
      expect(kitchen_one.reload.front_page_photo).not_to eq(photo_two)
    end
  end  

end

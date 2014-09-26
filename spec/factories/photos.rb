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

require 'carrierwave/test/matchers'

FactoryGirl.define do
  factory :photo do |p|
    p.picture Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/photos/photo_for_rspec.png')))
    p.kitchen { FactoryGirl.create(:kitchen) }
    p.picture_processing :false
  

    p.trait :with_kitchen do
      kitchen
    end

    factory :photo_with_kitchen, :traits => [:with_kitchen]
  end
end

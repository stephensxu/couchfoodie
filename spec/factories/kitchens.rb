# == Schema Information
#
# Table name: kitchens
#
#  id                  :integer          not null, primary key
#  name                :string(255)      not null
#  description         :text             not null
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
#
# Indexes
#
#  index_kitchens_on_front_page_photo_id  (front_page_photo_id)
#  index_kitchens_on_user_id              (user_id)
#




FactoryGirl.define do
  factory :kitchen do |k|
    k.name { Faker::Company.name }
    k.description "some description about my kitchen"
    k.street_address { Faker::Address.street_address }
    k.city { Faker::Address.city }
    k.state { Kitchen::VALID_STATES.sample }
    k.zipcode { Faker::Address.zip }
    k.user { FactoryGirl.create(:user) }

    k.trait :with_user do
      user
    end

    factory :kitchen_with_user, :traits => [:with_user]
  end
end

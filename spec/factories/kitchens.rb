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
#

FactoryGirl.define do
  factory :kitchen do |k|
    k.name "mynewkitchen"
    k.description "some description about my kitchen"
    k.street_address "2124 google ave"
    k.city "San Jose"
    k.state "CA"
    k.zipcode "91585"
    k.user { FactoryGirl.create(:user) }

    k.trait :with_user do
      user
    end

    factory :kitchen_with_user, :traits => [:with_user]
  end
end

# == Schema Information
#
# Table name: reservations
#
#  id                 :integer          not null, primary key
#  status             :string(255)      default("pending"), not null
#  reserve_date       :date             not null
#  reserve_time       :time             not null
#  message_from_guest :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :integer          not null
#  kitchen_id         :integer          not null
#  guest_number       :integer          default(1), not null
#  message_from_host  :string(255)
#
# Indexes
#
#  index_reservations_on_kitchen_id  (kitchen_id)
#  index_reservations_on_user_id     (user_id)
#



require 'date'

FactoryGirl.define do
  factory :reservation do
    status "pending"
    reserve_date { DateTime.new(2015, 6, 1) }
    reserve_time { Time.now }
    message_from_guest "Can I eat here please"
    guest_number 2
    user { FactoryGirl.create(:user) }
    kitchen { FactoryGirl.create(:kitchen) }

    trait :with_user do
      user
    end

    factory :reservation_with_user, :traits => [:with_user]
  end
end

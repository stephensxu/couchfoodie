# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#


FactoryGirl.define do
  factory :user do |u|
    u.email { Faker::Internet.email }
    u.password { Faker::Internet.password(min_length = 6) }
    u.nickname { Faker::Name.title }
    u.password_confirmation { |u| u.password }
  end
end

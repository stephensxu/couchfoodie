# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  nickname        :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

FactoryGirl.define do
  factory :reservation do |r|
    r.email { Faker::Internet.email }
    r.password { Faker::Internet.password(min_length = 6) }
    r.nickname "mynickname123"
    r.password_confirmation { |r| r.password }
  end
end

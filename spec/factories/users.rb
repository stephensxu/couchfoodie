# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  email       :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  provider    :string(255)      not null
#  oauth_token :string(255)      not null
#  uid         :string(255)      not null
#  name        :string(255)      not null
#  first_name  :string(255)
#  last_name   :string(255)
#  nickname    :string(255)
#  image       :string(255)
#  location    :string(255)
#  gender      :string(255)
#  verified    :boolean
#  link        :string(255)
#  timezone    :integer
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

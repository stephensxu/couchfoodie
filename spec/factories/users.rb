FactoryGirl.define do
  factory :user do |u|
    u.email { Faker::Internet.email }
    u.password { Faker::Internet.password(min_length = 6) }
    u.nickname "mynickname123"
    u.password_confirmation { |u| u.password }
  end
end

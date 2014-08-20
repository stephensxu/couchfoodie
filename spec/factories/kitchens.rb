FactoryGirl.define do
  factory :kitchen do |k|
    k.name "mynewkitchen"
    k.description "some description about my kitchen"
    k.street_address "2124 google ave"
    k.city "San Jose"
    k.state "CA"
    k.zipcdoe "91585"

    k.trait :with_user do
      user
    end

    factory :kitchen_with_user, :traits => [:with_user]
  end
end

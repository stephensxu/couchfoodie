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



require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_many(:kitchens) }
  it { should have_many(:reservations) }
  
  describe "#valid?" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:nickname) }
    it { should validate_presence_of(:created_at) }
    it { should ensure_length_of(:nickname).is_at_least(6) }
    it { should allow_value("I am King", "abcde123", "915823fb").for(:nickname) }
    it { should_not allow_value(1, true, false, "#@**#", "195&%$fjg", "@$$%^").for(:nickname) }
    it { should ensure_length_of(:email).is_at_least(6) }
    it { should ensure_length_of(:password).is_at_least(6) }
    it { should allow_value("waffle@gmail.com", "foo+bar@gmail.io").for(:email) }
    it { should_not allow_value("@", "jim@", "@iams", "stephens@1234ji").for(:email) }
    it { should allow_value("123456", "abcdefg123", "abcdefgibme", "isigjsdflsj").for(:password) }
    it { should_not allow_value("1", "123", "12345", "abcde").for(:password) }
    it { should validate_confirmation_of(:password) }
  end
end

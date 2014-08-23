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
  it { should have_many(:pending_reservations).through(:kitchens) }
  
  describe "#valid?" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:nickname) }
    it { should ensure_length_of(:nickname).is_at_least(6) }
    it { should allow_value("I am King", "abcde123", "915823fb").for(:nickname) }
    it { should_not allow_value("@$$%^").for(:nickname) }
    it { should_not allow_value("195&%$fjg").for(:nickname) }
    it { should ensure_length_of(:email).is_at_least(6) }
    it { should ensure_length_of(:password).is_at_least(6) }
    it { should allow_value("waffle@gmail.com", "foo+bar@gmail.io").for(:email) }

    %w(@ jim@ @iams stephens@1234ji).each do |bad_email|
      it { should_not allow_value(bad_email).for(:email) }
    end

    it { should allow_value("123456", "abcdefg123", "abcdefgibme", "isigjsdflsj").for(:password) }

    it { should_not allow_value("1", "123", "12345", "abcde").for(:password) }

    %w(1 123 12345 abcde).each do |bad_password|
      it { should_not allow_value(bad_password).for(:password)}
    end
    
    it { should validate_confirmation_of(:password) }
  end

  describe "user" do
    describe "validations" do
      subject { FactoryGirl.create(:user) }
      it { should validate_uniqueness_of(:nickname) }
    end
  end

  describe "#pending_reservations_count" do
    let(:user_one) { FactoryGirl.create(:user) }
    let(:user_two) { FactoryGirl.create(:user) }

    it "returns total number of pending reservations for a logged in user" do
      kitchen_one = FactoryGirl.create(:kitchen_with_user, :user => user_one)
      reservation_one = FactoryGirl.create(:reservation_with_user, :kitchen => kitchen_one, :user => user_one)
      reservation_two = FactoryGirl.create(:reservation_with_user, :kitchen => kitchen_one, :user => user_one)
      reservation_three = FactoryGirl.create(:reservation_with_user, :status => "approved", :kitchen => kitchen_one, :user => user_one)
      expect(user_one.pending_reservations_count).to eq(2)
    end

    it "return's 0 if there is not pending reservations" do
      expect(user_two.pending_reservations_count).to eq(0)
    end
  end
end

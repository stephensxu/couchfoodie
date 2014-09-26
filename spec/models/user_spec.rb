# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  provider        :string(255)      not null
#  oauth_token     :string(255)      not null
#  uid             :string(255)      not null
#  name            :string(255)      not null
#  first_name      :string(255)
#  last_name       :string(255)
#  nickname        :string(255)
#  image           :string(255)
#  location        :string(255)
#  gender          :string(255)
#  verified        :boolean
#  link            :string(255)
#  timezone        :integer
#  sign_in_count   :integer          default(1), not null
#  last_sign_in_at :datetime
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#






require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_many(:kitchens) }
  it { should have_many(:reservations) }
  it { should have_many(:active_pending_reservations).through(:kitchens) }
  it { should have_many(:in_future_pending_reservations).through(:kitchens) }
  
  describe "#valid?" do
    it { should validate_presence_of(:email) }

    it { should ensure_length_of(:email).is_at_least(6) }
    it { should allow_value("waffle@gmail.com", "foo+bar@gmail.io").for(:email) }

    %w(@ jim@ @iams stephens@1234ji).each do |bad_email|
      it { should_not allow_value(bad_email).for(:email) }
    end

    it { should validate_presence_of(:provider) }
    it { should validate_presence_of(:uid) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:oauth_token) }

  end

  describe "user" do
    describe "validations" do
      subject { FactoryGirl.create(:user) }
      it { should validate_uniqueness_of(:email) }
    end
  end

  describe "#in_future_pending_reservations_count" do
    let(:user_with_reservations) { FactoryGirl.create(:user) }
    let(:user_without_reservations) { FactoryGirl.create(:user) }

    it "returns total number of pending reservations on future date for a logged in user" do
      kitchen_one = FactoryGirl.create(:kitchen_with_user, :user => user_with_reservations)
      reservation_one = FactoryGirl.create(:reservation_with_user, :kitchen => kitchen_one, :user => user_with_reservations)
      reservation_two = FactoryGirl.create(:reservation_with_user, :kitchen => kitchen_one, :user => user_with_reservations)
      reservation_three = FactoryGirl.create(:reservation_with_user, :status => "approved", :kitchen => kitchen_one, :user => user_with_reservations)
      expect(user_with_reservations.in_future_pending_reservations_count).to eq(2)
    end

    it "return's 0 if there is no pending reservations" do
      expect(user_without_reservations.in_future_pending_reservations_count).to eq(0)
    end
  end

  describe "#sign_in" do
    before do
      Timecop.freeze(Time.local(2014, 9, 1, 12, 0, 0))
    end
    let(:user) { FactoryGirl.create(:user) }
    it "updates last_sign_in_at to current time" do
      expect {
        user.sign_in
      }.to change { user.reload.last_sign_in_at }.to eq(Time.zone.now)
    end

    it "increments sign_in_count" do
      expect {
        user.sign_in
      }.to change { user.reload.sign_in_count }.by(1)
    end
  end
end

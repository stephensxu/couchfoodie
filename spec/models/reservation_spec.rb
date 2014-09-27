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


require 'rails_helper'
require 'date'

RSpec.describe Reservation, :type => :model do

  ### Association test
  
  it { should belong_to(:kitchen) }
  it { should belong_to(:user) }

  ### Validation test

  describe "#valid?" do
    it { should validate_presence_of(:status) }
    it { should ensure_inclusion_of(:status).in_array( %w(pending denied approved archive)) }

    %w(soemthing deleted 1234 deny approve).each do |invalid_status|
      it { should_not allow_value(invalid_status).for(:status) }
    end

    it { should validate_presence_of(:reserve_date) }
    it { should_not allow_value(DateTime.new(2000)).for(:reserve_date) }
    it { should_not allow_value(1.year.from_now).for(:reserve_date) }
    it { should_not allow_value(10.years.from_now).for(:reserve_date) }
    it { should_not allow_value(Time.now).for(:reserve_date) }
    it { should allow_value(11.months.from_now).for(:reserve_date) }
    it { should allow_value(3.days.from_now).for(:reserve_date) }
    it { should allow_value(1.days.from_now).for(:reserve_date) }

    it { should validate_presence_of(:reserve_time) }

    it { should validate_presence_of(:message_from_guest) }
    it { should ensure_length_of(:message_from_guest).is_at_least(10) }

    it { should validate_presence_of(:guest_number) }
    it { should allow_value(1,2,5,9).for(:guest_number) }

    [0,-100,13,10000].each do |invalid_guest_number|
      it { should_not allow_value(invalid_guest_number).for(:guest_number) }
    end

    it { should validate_presence_of(:user) }

    it { should validate_presence_of(:kitchen) }
  end

  ### Method test

  describe '#editable_by?' do
    let(:other_user) { FactoryGirl.create(:user) }
    let(:reservation) { FactoryGirl.create(:reservation) }

    it "returns true for the user who created the reservation" do
      expect(reservation).to be_editable_by(reservation.user)
    end

    it "returns false for a user who did not create the reservation" do
      expect(reservation).to_not be_editable_by(other_user)
    end

    it "returns false for an anonymous user" do
      expect(reservation).to_not be_editable_by(nil)
    end
  end

  describe "#archive!" do
    let(:reservation) { FactoryGirl.create(:reservation) }
    it "change the status of reservation to archive" do
      expect {
        reservation.archive!
      }.to change{ reservation.reload.status }.to eq("archive")
    end
  end

  describe "#in_future?" do
    before do
      Timecop.travel(2015, 9, 1, 12, 0, 0)
    end

    after do
      Timecop.return
    end

    it "returns true if the reserve_date is at least one day ahead of current date" do
      reservation_one = FactoryGirl.create(:reservation, :reserve_date => Time.new(2015, 11, 1, 12, 0, 0))
      expect(reservation_one.in_future?).to eq(true)
    end

    it "returns false if the reserve_date is today's date" do
      Timecop.scale(86_400)
      reservation_two = FactoryGirl.create(:reservation, :reserve_date => Time.new(2015, 9, 2, 12, 0, 0))
      sleep(1)
      expect(reservation_two.in_future?).to eq(false)
    end
  end

  ### scope test

  describe "scope :for_user" do
    let(:reservation) { FactoryGirl.create(:reservation) }
    let(:other_user) { FactoryGirl.create(:user) }
    it "returns all the reservations created by a certain user" do
      user_reservations = Reservation.for_user(reservation.user)
      expect(user_reservations).to include(reservation)
    end

    it "does not return reservation that's created by a different user" do
      other_reservations = Reservation.for_user(other_user)
      expect(other_reservations).not_to include(reservation)
    end
  end

  describe "scope :pending" do
    let(:reservation_pending) { FactoryGirl.create(:reservation, :status => "pending") }
    let(:reservation_approved) { FactoryGirl.create(:reservation, :status => "approved") }

    it "returns reservations with 'pending' status" do
      pending_reservations = Reservation.pending
      expect(pending_reservations).to include(reservation_pending)
    end

    it "does not return reservations with 'approved' status" do
      pending_reservations = Reservation.pending
      expect(pending_reservations).to_not include(reservation_approved)
    end
  end

  describe "scope :approved" do
    let(:reservation_pending) { FactoryGirl.create(:reservation, :status => "pending") }
    let(:reservation_approved) { FactoryGirl.create(:reservation, :status => "approved") }

    it "returns reservations with 'approved' status" do
      approved_reservations = Reservation.approved
      expect(approved_reservations).to include(reservation_approved)
    end

    it "does not return reservations with 'pending' status" do
      approved_reservations = Reservation.approved
      expect(approved_reservations).to_not include(reservation_pending)
    end
  end

  describe "scope :denied" do
    let(:reservation_pending) { FactoryGirl.create(:reservation, :status => "pending") }
    let(:reservation_denied) { FactoryGirl.create(:reservation, :status => "denied") }

    it "returns reservations with 'denied' status" do
      denied_reservations = Reservation.denied
      expect(denied_reservations).to include(reservation_denied)
    end

    it "does not return reservations with 'pending' status" do
      denied_reservations = Reservation.denied
      expect(denied_reservations).to_not include(reservation_pending)
    end
  end

  describe "scope :active" do
    before do
      Timecop.travel(2015, 9, 1, 12, 0, 0)
    end

    after do
      Timecop.return
    end

    it "returns reservation with reserve_date that's at least one day away from today" do
      reservation_one = FactoryGirl.create(:reservation, :reserve_date => Time.new(2015, 11, 1, 12, 0, 0))
      expect(Reservation.active).to include(reservation_one)
    end

    it "return reservation with reserve_date that is today" do
      Timecop.scale(86_400)
      reservation_two = FactoryGirl.create(:reservation, :reserve_date => Time.new(2015, 9, 2, 12, 0, 0))
      sleep(1)
      expect(Reservation.active).to include(reservation_two)
    end

    it "does not return reservation with reserve_date that is in the past" do
      Timecop.scale(172_800)
      reservation_three = FactoryGirl.create(:reservation, :reserve_date => Time.new(2015, 9, 2, 12, 0, 0))
      sleep(1)
      expect(Reservation.active).not_to include(reservation_three)
    end
  end


  describe "scope :in_future" do
    before do
      Timecop.travel(2015, 9, 1, 12, 0, 0)
    end

    after do
      Timecop.return
    end

    it "returns reservation with reserve_date that's at least one day away from today" do
      reservation_one = FactoryGirl.create(:reservation, :reserve_date => Time.new(2015, 11, 1, 12, 0, 0))
      expect(Reservation.in_future).to include(reservation_one)
    end

    it "does not return reservation with reserve_date that's equal or before today's date" do
      Timecop.scale(86_400)
      reservation_two = FactoryGirl.create(:reservation, :reserve_date => Time.new(2015, 9, 2, 12, 0, 0))
      sleep(1)
      expect(Reservation.in_future).not_to include(reservation_two)
    end
  end
end

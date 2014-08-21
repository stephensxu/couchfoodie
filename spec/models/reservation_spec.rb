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

RSpec.describe Reservation, :type => :model do
  it { should belong_to(:kitchen) }
  it { should belong_to(:user) }

  describe "#valid?" do
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:reserve_date) }
    it { should validate_presence_of(:reserve_time) }
    it { should validate_presence_of(:message_from_guest) }
    it { should validate_presence_of(:guest_number) }
  end
end

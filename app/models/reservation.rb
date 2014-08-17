# == Schema Information
#
# Table name: reservations
#
#  id           :integer          not null, primary key
#  status       :string(255)      default("pending"), not null
#  reserve_date :date             not null
#  reserve_time :time             not null
#  message      :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#  kitchen_id   :integer
#
# Indexes
#
#  index_reservations_on_kitchen_id  (kitchen_id)
#  index_reservations_on_user_id     (user_id)
#

require 'date'

class Reservation < ActiveRecord::Base
  scope :for_user, lambda { |user| where(:user => user) }

  validates :status, :presence => true
  validates :reserve_date, :presence => true
  validates :reserve_time, :presence => true
  validates :message, :presence => true, :length => { :minimum => 10 }
  validates :user_id, :presence => true
  validates :kitchen_id, :presence => true

  def self.current_date
    Time.now
  end

  belongs_to :user
  belongs_to :kitchen
end

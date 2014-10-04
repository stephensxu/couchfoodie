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


require 'date'

class Reservation < ActiveRecord::Base

  before_update :send_status_update_email

  VALID_GUEST_NUMBER = [1, 2, 3, 4, 5, 6, 7, 8, 9]

  scope :for_user, lambda { |user| where(:user => user) }
  scope :pending, lambda { where(:status => 'pending') }
  scope :approved, lambda { where(:status => 'approved') }
  scope :denied, lambda { where(:status => 'denied') }
  scope :active, lambda { where("reserve_date >= '#{Time.now.to_date}'")}
  scope :in_future, lambda { where("reserve_date > '#{Time.now.to_date}'")}

  validates :status, :presence => true, :inclusion => { :in => ["pending", "denied", "approved", "archive"] }
  validates :reserve_date, :presence => true,
            :timeliness => { :after => lambda { Date.current }, :before =>  lambda { Date.current + 1.year },
            :type => :date, :after_message => "reservation has to be in the future",
            :before_message => "can't be more than 1 year ahead"}
  validates :reserve_time, :presence => true
  validates :message_from_guest, :presence => true, :length => { :minimum => 10 }
  validates :user, :presence => true
  validates :kitchen, :presence => true
  validates :guest_number, :presence => true, 
            :inclusion => { :in => VALID_GUEST_NUMBER }

  belongs_to :user
  belongs_to :kitchen

  def editable_by?(user)
    user.present? && self.user == user
  end

  def archive!
    self.update_attributes(:status => "archive")
  end

  def in_future?
    self.reserve_date > Time.now.to_date
  end

  def send_new_reservation_email(kitchen)
    ReservationMailer.notify_kitchen_owner_of_new_reservation(kitchen.user).deliver
  end

  def send_status_update_email
    if status_was == "pending" && status == "approved"
      ReservationMailer.notify_guest_reservation_approval(self.user).deliver
    elsif status_was == "pending" && status == "denied"
      ReservationMailer.notify_guest_reservation_denial(self.user).deliver
    end
  end
end

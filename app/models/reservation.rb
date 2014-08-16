require 'date'
class Reservation < ActiveRecord::Base
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

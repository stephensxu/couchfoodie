require 'date'
class Reservation < ActiveRecord::Base
  validates :status, :presence => true
  validates :reserve_date, :presence => true, :date => { :after => :current_date }
  validates :reserve_time, :presence => true
  validates :created_at, :presence => true
  validates :user_id, :presence => true
  validates :kitchen_id, :presence => true

  def self.current_date
    Time.now
  end

  belongs_to :user
  belongs_to :kitchen
end

  # create_table "reservations", force: true do |t|
  #   t.string   "status",       default: "pending", null: false
  #   t.date     "reserve_date",                     null: false
  #   t.time     "reserve_time",                     null: false
  #   t.string   "message"
  #   t.datetime "created_at",                       null: false
  #   t.datetime "updated_at",                       null: false
  #   t.integer  "user_id"
  #   t.integer  "kitchen_id"
  # end

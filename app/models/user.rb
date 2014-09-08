# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#




class User < ActiveRecord::Base
  has_secure_password

  validates :email, :presence => true, :uniqueness => true, :length => { :minimum => 6 }, :email => true
  validates :password, :presence => true, :length => { :minimum => 6 }, :confirmation => true
  validates :nickname, :presence => true, :length => { :minimum => 6 }, :uniqueness => true,
            :format => { :with => /\A[\w\s]+\z/, message: "nickname cannot contain special characters such as @#$%" }

  has_many :kitchens
  has_many :reservations
  has_many :pending_reservations, :through => :kitchens
  

  def pending_reservations_count
    pending_reservations.count
  end
end

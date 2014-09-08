# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  email       :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  provider    :string(255)      not null
#  oauth_token :string(255)      not null
#  uid         :string(255)      not null
#  name        :string(255)      not null
#  first_name  :string(255)
#  last_name   :string(255)
#  nickname    :string(255)
#  image       :string(255)
#  location    :string(255)
#  gender      :string(255)
#  verified    :boolean
#  link        :string(255)
#  timezone    :integer
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

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

class User < ActiveRecord::Base
  has_secure_password

  validates :email, :presence => true, :uniqueness => true, :length => { :minimum => 6 }, :email => true
  validates :password, :presence => true, :length => { :minimum => 6 }, :confirmation => true
  validates :nickname, :presence => true, :length => { :minimum => 6 }, :uniqueness => true,
            :format => { :with => /[\w\s]+/, message: "nickname can only be letters and numbers"}

  has_many :kitchens
  has_many :reservations
end

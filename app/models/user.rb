class User < ActiveRecord::Base
  has_secure_password

  validates :email, :presence => true, :uniqueness => true, :length => { :minimum => 6 }, :email => true
  validates :password, :presence => true, :length => { :minimum => 6 }, :confirmation => true
  validates :nick_name, :presence => true, :length => { :minimum => 6 }, 
            :format => { :with => /[\w\s]+/, message: "nickname can only be letters and numbers"}

  has_one :kitchen
end

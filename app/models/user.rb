# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  provider        :string(255)      not null
#  oauth_token     :string(255)      not null
#  uid             :string(255)      not null
#  name            :string(255)      not null
#  first_name      :string(255)
#  last_name       :string(255)
#  nickname        :string(255)
#  image           :string(255)
#  location        :string(255)
#  gender          :string(255)
#  verified        :boolean
#  link            :string(255)
#  timezone        :integer
#  sign_in_count   :integer          default(1), not null
#  last_sign_in_at :datetime
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#


class User < ActiveRecord::Base

  validates :email, :presence => true, :uniqueness => true, :length => { :minimum => 6 }, :email => true
  validates :provider, :presence => true
  validates :uid, :presence => true
  validates :name, :presence => true
  validates :oauth_token, :presence => true

  has_many :kitchens
  has_many :reservations
  has_many :active_pending_reservations, :through => :kitchens
  has_many :in_future_pending_reservations, :through => :kitchens
  

  def in_future_pending_reservations_count
    in_future_pending_reservations.count
  end

  def sign_in
    self.update_columns(:last_sign_in_at => Time.zone.now)
    self.update_columns(:sign_in_count => self.sign_in_count += 1)
  end

  def self.create_or_find_with_omniauth(auth)
    self.find_by_provider_and_uid(auth["provider"], auth["uid"]) || self.create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.email = auth['info']['email']
      user.provider = auth['provider']
      user.oauth_token = auth['credentials']['token']
      user.uid = auth['uid']
      user.name = auth['info']['name']
      user.first_name = auth['info']['first_name']
      user.last_name = auth['info']['last_name']
      user.nickname = auth['info']['nickname']
      user.image = auth['info']['image']
      user.location = auth['info']['location']
      user.gender = auth['extra']['raw_info']['gender']
      user.verified = auth['info']['verified']
      user.link = auth['extra']['raw_info']['link']
      user.timezone = auth['extra']['raw_info']['timezone']
    end
  end
end

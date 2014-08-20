# == Schema Information
#
# Table name: kitchens
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  description    :string(255)      not null
#  street_address :string(255)      not null
#  city           :string(255)      not null
#  state          :string(255)      not null
#  zipcode        :string(255)      not null
#  latitude       :float
#  longtitude     :float
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer          not null
#  data_status    :string(255)      default("active"), not null
#
# Indexes
#
#  index_kitchens_on_user_id  (user_id)
#


class Kitchen < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true, :length => { :minimum => 6 , :maximum => 50 }
  validates :description, :presence => true, :length => { :minimum => 10, :maximum => 250 }
  validates :street_address, :presence => true, :length => { :minimum => 6 }
  validates :city, :presence => true, :length => { :minimum => 3 }
  validates :state, :presence => true, :length => { :minimum => 2, :maximum => 2 },
            :format => { :with => /[[:alpha:]]{2}/, message: "can only be 2 character abbreviation"}
  validates :zipcode, :presence => true,
            :format => { :with => /\d{5}(-\d{4})/, message: "can only be 5 digit numbers"}

  validates :user, :presence => true

  belongs_to :user
  has_many :reservations

  scope :for_user, lambda { |user| where(:user => user) }

  def editable_by?(user)
    user.present? && self.user == user
  end

  def archive!(kitchen)
    update_attributes(:data_status => "archive")
  end

  belongs_to :user
  has_many :reservations
end

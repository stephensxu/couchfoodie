# == Schema Information
#
# Table name: kitchens
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  description    :text             not null
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
  validates :description, :presence => true, :length => { :in => (10..250)  }
  validates :street_address, :presence => true, :length => { :minimum => 6, :maximum => 50 }
  validates :city, :presence => true, :length => { :in => (3..50) }
  validates :state, :presence => true, :length => { :is => 2 },
            :format => { :with => /[[:alpha:]]{2}/, message: "can only be 2 character abbreviation"}
  validates :zipcode, :presence => true, :length => { :minimum => 5 },
            :format => { :with => /\A\d{5}(-\d{4})?\z/, message: "should be in the form 91234 or 91234-6789"}
  validates :data_status, :presence => true, :inclusion => { :in => ["active", "archive"] }

  validates :user, :presence => true

  belongs_to :user
  has_many :reservations
  has_many :pending_reservations, 
           lambda { pending },
           :class_name => 'Reservation'

  scope :for_user, lambda { |user| where(:user => user) }

  def editable_by?(user)
    user.present? && self.user == user
  end

  def editable?
    self.data_status == "active"
  end

  def archive!
    self.update_attributes(:data_status => "archive")
  end

  VALID_STATES = %w(AL AK AZ AR CA CO CT DE FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO
                    MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV MI WY
                    AS DC FM GU MH MP PW PR VI AE AA AP).sort
  # This list contains abbreviation for 50 States in US + 9 commonwealth/territory + 3 Military State

  belongs_to :user
  has_many :reservations
end

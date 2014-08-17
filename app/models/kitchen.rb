class Kitchen < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true, :length => { :minimum => 6 }
  validates :description, :presence => true, :length => { :minimum => 10, :maximum => 500 }
  validates :street_address, :presence => true, :uniqueness => true, :length => { :minimum => 6 }
  validates :city, :presence => true, :length => { :minimum => 3 },
            :format => { :with => /[[:alpha:]+]/, message: "name can only be letters"}
  validates :state, :presence => true, :length => { :minimum => 2, :maximum => 2 },
            :format => { :with => /[[:alpha:]]{2}/, message: "can only be 2 character abbrivation"}
  validates :zipcode, :presence => true,
            :format => { :with => /[[:digit:]]{5}/, message: "can only be 5 digit numbers"}

  validates :user_id, :presence => true, :numericality => true

  def editable_by?(user)
    user.present? && self.user == user
  end

  belongs_to :user
  has_many :reservations
end

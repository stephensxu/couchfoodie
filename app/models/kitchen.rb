# == Schema Information
#
# Table name: kitchens
#
#  id                  :integer          not null, primary key
#  name                :string(255)      not null
#  description         :text
#  street_address      :string(255)      not null
#  city                :string(255)      not null
#  state               :string(255)      not null
#  zipcode             :string(255)      not null
#  latitude            :float
#  longtitude          :float
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :integer          not null
#  data_status         :string(255)      default("active"), not null
#  front_page_photo_id :integer
#  menu                :string(255)      not null
#
# Indexes
#
#  index_kitchens_on_front_page_photo_id  (front_page_photo_id)
#  index_kitchens_on_user_id              (user_id)
#


class Kitchen < ActiveRecord::Base

  # VALID_STATES = %w(AL AK AZ AR CA CO CT DE FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO
  #                   MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV MI WY
  #                   AS DC FM GU MH MP PW PR VI AE AA AP).sort
  # This list contains abbreviation for 50 States in US + 9 commonwealth/territory + 3 Military State
  
  VALID_STATES = %w(CA)

  VALID_CITIES = ["Alameda", "Albany", "American Canyon", "Antioch", "Belmont", "Belvedere", "Benicia", "Berkeley",
  "Brentwood", "Brisbane", "Burlingame", "Calistoga", "Campbell", "Clayton", "Cloverdale", "Concord",
  "Cotati", "Cupertino", "Daly City", "Dixon", "Dublin", "East Palo Alto", "El Cerrito", "Emeryville",
  "Fairfield", "Foster City", "Fremont", "Gilroy", "Half Moon Bay", "Hayward", "Healdsburg", "Hercules",
  "Lafayette", "Larkspur", "Livermore", "Los Altos", "Martinez", "Menlo Park", "Mill Valley", "Millbrae",
  "Milpitas", "Monte Sereno", "Morgan Hill", "Mountain View", "Napa", "Newark", "Novato", "Oakland",
  "Oakley", "Orinda", "Pacifica", "Palo Alto", "Petaluma", "Piedmont", "Pinole", "Pittsburg", "Pleasant Hill",
  "Pleasanton", "Redwood City", "Richmond", "Rio Vista", "Rohnert Park", "San Bruno", "San Carlos",
  "San Francisco", "San Jose", "San Leandro", "San Mateo", "San Pablo", "San Rafael", "San Ramon",
  "Santa Clara", "Santa Rosa", "Saratoga", "Sausalito", "Sebastopol", "Sonoma", "South San Francisco",
  "St. Helena", "Suisun City", "Sunnyvale", "Union City", "Vacaville", "Vallejo", "Walnut Creek",
  "Atherton", "Colma", "Corte Madera", "Danville", "Fairfax", "Hillsborough", "Los Altos Hills",
  "Los Gatos", "Moraga", "Portola Valley", "Ross", "San Anselmo", "Tiburon", "Windsor", "Woodside",
  "Yountvill"].sort

  scope :for_user, lambda { |user| where(:user => user) }
  scope :active, lambda { where(:data_status => "active") }
  scope :with_photo, lambda { where.not(:front_page_photo => nil) }
  scope :published, lambda { active.with_photo }

  validates :name, :presence => true, :uniqueness => true, :length => { :minimum => 6 , :maximum => 50 }
  validates :menu, :presence => true, :length => { :in => (5..250)  }
  validates :description, :length => { :maximum => 250  }
  validates :street_address, :presence => true, :length => { :minimum => 6, :maximum => 50 }
  validates :city, :presence => true, :inclusion => { :in => VALID_CITIES }
  validates :state, :presence => true, :length => { :is => 2 },
            :inclusion => { :in => VALID_STATES }
  validates :zipcode, :presence => true, :length => { :minimum => 5 },
            :format => { :with => /\A\d{5}(-\d{4})?\z/, message: "should be in the form 91234 or 91234-6789"}
  validates :data_status, :presence => true, :inclusion => { :in => ["active", "archive"] }

  validates :user, :presence => true

  belongs_to :user
  belongs_to :front_page_photo, :class_name => "Photo"
  has_many :reservations
  has_many :photos
  has_many :active_pending_reservations, 
           lambda { Reservation.pending.active },
           :class_name => 'Reservation'
  has_many :in_future_pending_reservations,
           lambda { Reservation.pending.in_future },
           :class_name => 'Reservation'
  has_many :processed_photos,
           lambda { processed },
           :class_name => "Photo"
  has_many :unprocessed_photos,
           lambda { unprocessed },
           :class_name => "Photo"

  def editable_by?(user)
    self.editable? && user.present? && self.user == user
  end

  def editable?
    self.data_status == "active"
  end

  def archive!
    self.update_attributes(:data_status => "archive")
  end

  def archived?
    self.data_status == 'archive'
  end

  def set_front_page_photo(photo)
    self.front_page_photo = photo
    self.save!
  end

  def show_front_page_photo_thumbnail
    if self.front_page_photo
      self.front_page_photo.picture.gallery_fill_thumbnail.url
    end
  end

  def show_cover_photo
    if self.front_page_photo
      self.front_page_photo.picture.gallery_fill_cover.url
    end
  end

end

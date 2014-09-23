# == Schema Information
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  picture            :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  kitchen_id         :integer          not null
#  picture_tmp        :string(255)
#  processed_at       :datetime
#  picture_processing :boolean          default(FALSE), not null
#
# Indexes
#
#  index_photos_on_kitchen_id  (kitchen_id)
#


class Photo < ActiveRecord::Base
  mount_uploader :picture, KitchenPhotosUploader
  process_in_background :picture

  before_update :set_processed_at!
  after_commit :set_as_front_page_photo_if_first

  belongs_to :kitchen
  has_one :kitchen_displaying_as_front_page, :class_name => "Kitchen", :inverse_of => :front_page_photo

  validates :picture, :presence => true, 
            :file_size => { :maximum => 10.megabytes.to_i }

  scope :processed, lambda { where.not(:processed_at => nil) }
  scope :unprocessed, lambda { where(:processed_at => nil) }

  def set_as_front_page_photo_if_first
    if kitchen.front_page_photo.blank? && self.processed_at?
      kitchen.update!(:front_page_photo => self)
    end
  end

  def set_as_front_page_photo(kitchen)
    self.kitchen_displaying_as_front_page = kitchen
    self.kitchen.save
  end

  def standard_picture
    self.picture.gallery_fill.url
  end

  private 

  def set_processed_at!
    if picture_processing_was == true && picture_processing == false
      write_attribute(:processed_at, Time.zone.now)
    end
  end
end

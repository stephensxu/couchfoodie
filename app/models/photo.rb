# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  picture    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  kitchen_id :integer          not null
#
# Indexes
#
#  index_photos_on_kitchen_id  (kitchen_id)
#

class Photo < ActiveRecord::Base
  after_create :set_as_front_page_photo_if_first

  belongs_to :kitchen
  has_one :kitchen_displaying_as_front_page, :class_name => "Kitchen", :inverse_of => :front_page_photo

  mount_uploader :picture, KitchenPhotosUploader

  validates :picture, :presence => true, 
            :file_size => { :maximum => 5.megabytes.to_i }

  def set_as_front_page_photo_if_first
    kitchen.update!(:front_page_photo => self) if kitchen.photos.count == 1
  end

  def standard_picture
    self.picture.gallery_fill.url
  end
end

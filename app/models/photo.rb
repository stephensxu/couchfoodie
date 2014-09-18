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
  # process_in_background :picture

  after_create :set_as_front_page_photo_if_first

  belongs_to :kitchen
  has_one :kitchen_displaying_as_front_page, :class_name => "Kitchen", :inverse_of => :front_page_photo

  validates :picture, :presence => true, 
            :file_size => { :maximum => 10.megabytes.to_i }

  def set_as_front_page_photo_if_first
    kitchen.update!(:front_page_photo => self) if kitchen.photos.count == 1
  end

  def set_as_front_page_photo(kitchen)
    self.kitchen_displaying_as_front_page = kitchen
    self.kitchen.save
  end

  def standard_picture
    self.picture.gallery_fill.url
  end
end

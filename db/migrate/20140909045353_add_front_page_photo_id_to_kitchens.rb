class AddFrontPagePhotoIdToKitchens < ActiveRecord::Migration
  def change
    add_reference :kitchens, :front_page_photo, index: true
  end
end

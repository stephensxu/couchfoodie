class AddPictureProcessingToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :picture_processing, :boolean, :null => false, :default => false
  end
end

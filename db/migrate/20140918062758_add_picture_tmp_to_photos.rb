class AddPictureTmpToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :picture_tmp, :string
  end
end

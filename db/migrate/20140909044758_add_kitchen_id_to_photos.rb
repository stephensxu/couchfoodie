class AddKitchenIdToPhotos < ActiveRecord::Migration
  def change
    add_reference :photos, :kitchen, index: true, :null => false
  end
end

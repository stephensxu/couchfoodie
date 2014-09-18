class AddProcessedAtToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :processed_at, :datetime
  end
end

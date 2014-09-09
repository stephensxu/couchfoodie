class CreatePhotos < ActiveRecord::Migration
  def up
    create_table :photos do |t|
      t.string :picture, :null => false

      t.timestamps
    end
  end

  def down
    drop_table :photos
  end
end

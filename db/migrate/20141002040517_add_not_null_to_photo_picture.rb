class AddNotNullToPhotoPicture < ActiveRecord::Migration
  def up
    change_column :photos, :picture, :string, :null => false
  end

  def down
    change_column :photos, :picture, :string, :null => true
  end
end

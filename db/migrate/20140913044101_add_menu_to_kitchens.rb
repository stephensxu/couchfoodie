class AddMenuToKitchens < ActiveRecord::Migration
  def change
    add_column :kitchens, :menu, :string, :null => false
  end
end

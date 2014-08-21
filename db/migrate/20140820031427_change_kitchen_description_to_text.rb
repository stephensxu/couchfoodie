class ChangeKitchenDescriptionToText < ActiveRecord::Migration
  def up
    change_column :kitchens, :description, :text, :null => false
  end

  def down
    change_column :kitchens, :description, :string, :null => false
  end
end

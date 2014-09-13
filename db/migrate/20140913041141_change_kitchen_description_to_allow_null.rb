class ChangeKitchenDescriptionToAllowNull < ActiveRecord::Migration
  def up
    change_column :kitchens, :description, :text, :null => true
  end

  def down
    change_column :kitchens, :description, :text, :null => false
  end
end

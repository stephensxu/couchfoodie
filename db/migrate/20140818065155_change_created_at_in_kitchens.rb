class ChangeCreatedAtInKitchens < ActiveRecord::Migration
  def change
    change_column :kitchens, :created_at, :datetime, :null => false
  end
end

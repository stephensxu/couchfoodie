class ChangeDescriptionInKitchens < ActiveRecord::Migration
  def change
    change_column :kitchens, :description, :text, :null => false
  end
end

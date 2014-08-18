class AddNullFalseToMultipleColumns < ActiveRecord::Migration
  def change
    change_column :kitchens,     :updated_at, :datetime, :null => false
    change_column :kitchens,     :user_id,    :integer,  :null => false
    change_column :reservations, :user_id,    :integer,  :null => false
    change_column :reservations, :kitchen_id, :integer,  :null => false
  end
end

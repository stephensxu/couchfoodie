class AddDataStatusToKitchens < ActiveRecord::Migration
  def change
    add_column :kitchens, :data_status, :string, :default => "active", :null => false
  end
end

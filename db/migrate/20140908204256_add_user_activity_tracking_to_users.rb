class AddUserActivityTrackingToUsers < ActiveRecord::Migration
  def up
    add_column :users, :sign_in_count, :integer, :default => 1, :null => false
    add_column :users, :last_sign_in_at, :datetime
  end

  def down
    remove_column :users, :login_times
    remove_column :users, :last_sign_in_at
  end
end

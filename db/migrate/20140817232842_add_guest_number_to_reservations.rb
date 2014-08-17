class AddGuestNumberToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :guest_number, :integer, :default => 1, :null => false
  end
end

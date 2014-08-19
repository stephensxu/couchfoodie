class ChangeMessageInReservations < ActiveRecord::Migration
  def change
    rename_column :reservations, :message, :message_from_guest
  end
end

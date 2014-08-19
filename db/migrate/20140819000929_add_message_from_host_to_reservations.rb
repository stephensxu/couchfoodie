class AddMessageFromHostToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :message_from_host, :string
  end
end

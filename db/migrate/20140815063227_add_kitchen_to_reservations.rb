class AddKitchenToReservations < ActiveRecord::Migration
  def change
    add_reference :reservations, :kitchen, index: true
  end
end

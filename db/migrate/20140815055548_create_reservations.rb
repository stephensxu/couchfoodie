class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :status, :default => "pending", :null => false
      t.date   :reserve_date, :null => false
      t.time   :reserve_time, :null => false 
      t.string :message, :null => false

      t.timestamps :null => false
    end
  end
end

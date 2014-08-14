class CreateKitchens < ActiveRecord::Migration
  def change
    create_table :kitchens do |t|
      t.string :name, :null => false
      t.string :description, :null => false
      t.string :street_address, :null => false
      t.string :city, :null => false
      t.string :state, :null => false
      t.string :zipcode, :null => false
      t.float  :latitude
      t.float  :longtitude

      t.timestamps
    end
  end
end

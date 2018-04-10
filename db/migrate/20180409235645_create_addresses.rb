class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string  :street
      t.string  :city
      t.string  :state
      t.string  :country
      t.integer :zipcode
      t.float   :latitude
      t.float   :longitude

      t.timestamps
    end
  end
end

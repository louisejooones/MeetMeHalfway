class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.references :meeting, null: false, foreign_key: true
      t.string :location_type
      t.string :location_name
      t.string :address
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.integer :distance_from_halfway
      t.integer :time_from_halfway

      t.timestamps
    end
  end
end

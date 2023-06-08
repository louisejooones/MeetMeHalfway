class ChangeColumnsInLocations < ActiveRecord::Migration[7.0]
  def change
    # Remove the latitude and longitude columns as Google does not allow us to store this information
    remove_column :locations, :latitude, :decimal
    remove_column :locations, :longitude, :decimal

    # Add the google_maps_place_id column
    add_column :locations, :google_maps_place_id, :string
  end
end

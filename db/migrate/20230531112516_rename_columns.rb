class RenameColumns < ActiveRecord::Migration[7.0]
  def change
    rename_column :locations, :location_name, :name
    rename_column :locations, :location_type, :type
  end
end

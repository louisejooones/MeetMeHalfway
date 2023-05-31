class CreateMeetings < ActiveRecord::Migration[7.0]
  def change
    create_table :meetings do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :place_type
      t.string :transport_type
      t.integer :total_distance
      t.integer :total_time

      t.timestamps
    end
  end
end

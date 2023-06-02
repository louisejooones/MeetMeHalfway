class AddDefaultToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :default, :boolean
  end
end

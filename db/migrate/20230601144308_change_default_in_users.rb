class ChangeDefaultInUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :default, :default_user
    change_column_default :users, :default_user, false
  end
end

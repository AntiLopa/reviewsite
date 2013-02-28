class AddPrivToUsers < ActiveRecord::Migration
  def change
    add_column :users, :priv, :string
  end
end

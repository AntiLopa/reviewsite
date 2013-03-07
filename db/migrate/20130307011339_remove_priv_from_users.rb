class RemovePrivFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :priv
  end

  def down
    add_column :users, :priv, :string
  end
end

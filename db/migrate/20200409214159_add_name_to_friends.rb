class AddNameToFriends < ActiveRecord::Migration[6.0]
  def change
    add_column :friends, :name, :string
  end
end

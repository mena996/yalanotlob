class CreateFriends < ActiveRecord::Migration[6.0]
  def change
    create_table :friends do |t|
      # add_foreign_key :friends, :users, column: :author_id
    end
  end
end

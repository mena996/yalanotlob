class CreateFriends < ActiveRecord::Migration[6.0]
  def change
    create_table :friends do |t|
    end
    add_reference :friends , :first_user, foreign_key: { to_table: :users}  
    add_reference :friends , :second_user, foreign_key: { to_table: :users} 
  end
end

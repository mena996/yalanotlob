class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :name
    end
    add_reference :groups , :admin, foreign_key: { to_table: :users} 
  end
end

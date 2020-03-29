class CreateUserGroup < ActiveRecord::Migration[6.0]
  def change
    create_table :user_groups do |t|
    end
    add_reference :user_groups, :user , foreign_key: true
    add_reference :user_groups, :group , foreign_key: true
  end
end

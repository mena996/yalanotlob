class CreateUserOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :user_orders do |t|
      t.string :item_name
      t.integer :amount
      t.decimal :price
      t.string :comment
    end
    add_reference :user_orders, :user , foreign_key: true
    add_reference :user_orders, :order , foreign_key: true
  end
end

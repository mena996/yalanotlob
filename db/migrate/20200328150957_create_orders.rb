class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :meal
      t.string :resturant
      t.string :menu
      t.string :order_status
    end
    add_reference :orders, :user , foreign_key: true
  end
end

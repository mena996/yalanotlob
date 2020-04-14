class AddCreatedAtToOrders < ActiveRecord::Migration[6.0]
  def change
    # add_column :orders, :created_at, :string
    add_column :orders, :created_at, :datetime
  end
end

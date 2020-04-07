class AddNotifiedToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :notified, :boolean
  end
end

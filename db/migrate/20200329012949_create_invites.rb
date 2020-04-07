class CreateInvite < ActiveRecord::Migration[6.0]
  def change
    create_table :invites do |t|
      t.integer :notified
      t.string :invitation_status
    end
    add_reference :invites, :user, foreign_key: true
    add_reference :invites, :order, foreign_key: true
  end
end

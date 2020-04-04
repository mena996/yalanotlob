class Group < ApplicationRecord

    belongs_to :owner, class_name: 'User' ,foreign_key: 'admin_id'
    has_and_belongs_to_many :users, :join_table => "user_groups"

end

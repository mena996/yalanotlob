class Order < ApplicationRecord
    # validates :meal, :restaurant, :menu, presence: true
    # has_many :invites, dependent: :delete_all
    has_many :user_orders
    belongs_to :users
end

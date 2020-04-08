class Order < ApplicationRecord
    validates :meal, :restaurant, :menu, presence: true
    belongs_to :user
    has_many :invites, dependent: :destroy
    has_many :user_orders, dependent: :delete_all
    attr_accessor :group
end

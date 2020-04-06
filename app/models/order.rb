class Order < ApplicationRecord
    # validates :meal, :restaurant, :menu, presence: true
    belongs_to :user
    has_many :invites, dependent: :delete_all
end

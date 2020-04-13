class Invite < ApplicationRecord
    belongs_to :user, class_name:"User"
    belongs_to :order, class_name:"Order"
    has_many :notifications, as: :notifiable , dependent: :destroy

    after_create :create_notifications

    def create_notifications
        Notification.create(recipient: self.user, actor: self.order.user,
            action: "invited you to his", notifiable: self)
    end
end

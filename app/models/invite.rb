class Invite < ApplicationRecord
    belongs_to :user, class_name:"User"
    belongs_to :order, class_name:"Order"
    after_create :create_notifications

    def create_notifications
        Notification.create(recipient: self.user, actor: self.order.user,
            action: "invited you to his", notifiable: self)
    end
end

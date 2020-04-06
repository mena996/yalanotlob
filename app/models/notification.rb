class Notification < ApplicationRecord
    belongs_to :recipient, class_name:"User"
    belongs_to :actor, class_name:"User"
    belongs_to :notifiable, polymorphic: true

    scope :unread, ->{where(read_at: nil)} 

    def get_invitaion_id(user_id, order_id)
        @invite= Invite.find_by(user_id: user_id, order_id: order_id)
        return @invite
    end
end

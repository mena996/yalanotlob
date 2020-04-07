class Notification < ApplicationRecord
    belongs_to :recipient, class_name:"User"
    belongs_to :actor, class_name:"User"
    belongs_to :notifiable, polymorphic: true

    scope :unread, ->{where(read_at: nil)}
    scope :unnotified, ->{where(notified: nil)} 

    # def get_invitaion_id(user_id, order_id)
    #     @invite= Invite.find_by(user_id: user_id, order_id: order_id)
    #     return @invite
    # end

    def type
        self.notifiable.class.to_s.underscore.humanize.downcase
    end

    def joined?
        if self.notifiable.invitation_status 
            return true
        else 
            return false
        end
    end

    def order_finished?
        if self.notifiable.order.status == 0
            return false
        else 
            return true
        end
    end
end

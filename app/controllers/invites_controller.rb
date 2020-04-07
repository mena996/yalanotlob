class InvitesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def join
        @invitaion= Invite.find(params[:id])
        if @invitaion.update(invitation_status: "1")
            Notification.create(recipient:@invitaion.order.user, actor:@invitaion.user, action:"Joind your", notifiable:@invitaion)
        end
        redirect_back fallback_location: root_path
    end
end

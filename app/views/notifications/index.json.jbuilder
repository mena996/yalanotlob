json.array! @notifications do |notification|
    json.id notification.id
    json.actor notification.actor.name
    json.action notification.action
    json.notifiable notification.notifiable
    # if(notification.notifiable.instance_of? Order)
    #     json.invitation_id notification.get_invitaion_id(notification.notifiable.user_id, notification.notifiable.id)
    # end
    json.order_status notification.notifiable.order.status
    json.date notification.created_at
    json.type "#{notification.notifiable.class.to_s.underscore.humanize.downcase}"
    json.url order_path(notification.notifiable.order)	
end
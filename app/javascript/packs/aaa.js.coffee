class Notifications 
    constructor:->
        @notifications= $("[data-behavior='notifications']")
        @setup() if @notifications.length>0

    setup: ->
     $("[data-behavior='notifications-link']").on "click",@handelClick  
     $("[data-behavior='join']").on "click",@handeljoin   
     $.ajax(
         url: "/notifications.json"
         dataType: "JSON"
         method: "GET"
         success: @handelSuccess
     )

    handelClick: (e)=>
        $.ajax(
            url: "/notifications/mark_as_read"
            dataType: "JSON"
            method: "POST"
            success: ->
                console.log("success")
                $("[data-behavior='unread-count']").text("");
                $("[data-behavior='unread-count2']").text("Notification(0)")
            )
    
        
    handelSuccess:(data) =>
        console.log(data)
        items= $.map data, (notification)->
            "<li class='notification-box'>
                <div class='row'>
                    <div class='col-lg-3 col-sm-3 col-3 text-center'>
                        <img src='/avatar.png' class='w-50 rounded-circle'>
                    </div>
                    <div class='col-lg-8 col-sm-8 col-8'>
                        <strong class='text-info'>#{notification.actor}</strong>
                        <div>
                          #{notification.actor} #{notification.action} #{'order'if notification.type=='invite'}
                        #{"<form method='POST' action='/invites/#{notification.notifiable.id}'>                        
                        <input type='hidden' name='_method' value='PUT'/>
                        <button class='btn btn-success btn-sm' id=#{notification.notifiable.id} data-behavior='join'  type='submit'>Join</button>
                        </form>" if notification.notifiable.invitation_status!='1' }
                        </div>
                        <small class='text-warning'>#{new Date(Date.parse(notification.date)).toLocaleString()}</small>
                    </div>
                </div>
            </li>"

        $("[data-behavior='unread-count']").text(items.length)
        $("[data-behavior='unread-count2']").text("Notification(#{items.length})")
        $("[data-behavior='notifications-items']").html(items)

jQuery ->
    new Notifications
var Notifications,
  bind = function (fn, me) { return function () { return fn.apply(me, arguments); }; };

Notifications = (function () {
  function Notifications() {
    this.handelSuccess = bind(this.handelSuccess, this);
    this.handelClick = bind(this.handelClick, this);
    this.notifications = $("[data-behavior='notifications']");
    if (this.notifications.length > 0) {
      this.setup();
    }
  }

  Notifications.prototype.setup = function () {
    $("[data-behavior='notifications-link']").on("click", this.handelClick);
    $("[data-behavior='join']").on("click", this.handeljoin);
    return $.ajax({
      url: "/notifications.json",
      dataType: "JSON",
      method: "GET",
      success: this.handelSuccess
    });
  };

  Notifications.prototype.handelClick = function (e) {
    return $.ajax({
      url: "/notifications/mark_as_read",
      dataType: "JSON",
      method: "POST",
      success: function () {
        console.log("success");
        $("[data-behavior='unread-count']").text("");
        return $("[data-behavior='unread-count2']").text("Notification(0)");
      }
    });
  };

  Notifications.prototype.handelSuccess = function (data) {
    var items;
    const joind = 1;
    const finished_order = 1;
    const join_action = "Joind your"
    console.log(data);
    items = $.map(data, function (notification) {
      let html = `<li class='notification-box'> 
      <div class='row'> <div class='col-lg-3 col-sm-3 col-3 text-center'> 
      <img src='/avatar.png' class='w-50 rounded-circle'> </div>
       <div class='col-lg-8 col-sm-8 col-8'> <strong class='text-info'>${notification.actor}</strong> <div> ${notification.actor} ${notification.action} ${(notification.type === 'invite' ? 'order' : void 0)}. `
      if(notification.action!= join_action){
        if (notification.notifiable.invitation_status != joind && notification.order_status != finished_order ){
          html+= "<form method='POST' action='/invites/" + notification.notifiable.id + "'> <input type='hidden' name='_method' value='PUT'/> <button class='btn btn-success btn-sm' id=" + notification.notifiable.id + " data-behavior='join'  type='submit'>Join</button> </form>"
        }
        else if(notification.order_status == finished_order) {
          html+= "<span>(Order finished)</span>"
        }
        else if(notification.notifiable.invitation_status==joind){
          html+= "<span> (already joined) </span>"
        }
      }
      else {
        html+=  `<a href='${notification.url}'>View order</a>`
      }
      
      html+=  `</div> <small class='text-warning'>" ${(new Date(Date.parse(notification.date)).toLocaleString())} "</small> </div> </div> </li>`
      return html
    });
    $("[data-behavior='unread-count']").text(items.length);
    $("[data-behavior='unread-count2']").text("Notification(" + items.length + ")");
    return $("[data-behavior='notifications-items']").html(items);
  };

  return Notifications;

})();

jQuery(function () {
  return new Notifications;
});









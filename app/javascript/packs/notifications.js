const notifications = function () {
  let notifications = $("[data-behavior='notifications']");
  if (notifications) {
    setup();
  }
}

const setup = function () {
  $("[data-behavior='notifications-link']").on("click", handelClick);
  $("[data-behavior='mark-all-read']").on("click", markAllRead);
  return $.ajax({
    url: "/notifications.json",
    dataType: "JSON",
    method: "GET",
    success: handelSuccess
  });
}

const markAllRead = function () {
  return $.ajax({
    url: "/notifications/mark_as_read",
    dataType: "JSON",
    method: "POST",
    success: function () {
      $(`.notification-box`).attr('class', 'notification-box');
    }
  });
}

const handelClick = function () {
  return $.ajax({
    url: "/notifications/mark_as_notified",
    dataType: "JSON",
    method: "POST",
    success: function () {
      $("[data-behavior='unread-count']").text("");
      return $("[data-behavior='unread-count2']").text("Notification(0)");
    }
  });
}

const handelSuccess = function (data) {
  var items;
  const joind = 1;
  const finished_order = 1;
  const join_action = "Joind your"
  let UnotifiedCount=0
  console.log(data);
  items = $.map(data, function (notification) {
    if (!notification.notified){
      UnotifiedCount+=1
    }
    let html = `<li id=${notification.id} class='notification-box ${notification.read? "":"bg-gray"}'> 
      <div class='row'> <div class='col-lg-3 col-sm-3 col-3 text-center'> 
      <img src='/avatar.png' class='w-50 rounded-circle'> </div>
       <div class='col-lg-8 col-sm-8 col-8'> <strong class='text-info'>${notification.actor}</strong> <div> ${notification.actor} ${notification.action} ${(notification.type === 'invite' ? 'order' : void 0)}. `
    if (notification.action != join_action) {
      if (notification.notifiable.invitation_status != joind && notification.order_status != finished_order) {
        html += "<form method='POST' action='/invites/" + notification.notifiable.id + "'> <input type='hidden' name='_method' value='PUT'/> <button class='btn btn-success btn-sm' id=" + notification.notifiable.id + " data-behavior='join'  type='submit'>Join</button> </form>"
      }
      else if (notification.order_status == finished_order) {
        html += "<span>(Order finished)</span>"
      }
      else if (notification.notifiable.invitation_status == joind) {
        html += "<span> (already joined) </span>"
      }
    }
    else {
      html += `<a href='${notification.url}'>View order</a>`
    }

    html += `</div> <small class='text-warning'>" ${(new Date(Date.parse(notification.date)).toLocaleString())} "</small> </div> </div> </li>`
    return html
  });
  $("[data-behavior='unread-count']").text(UnotifiedCount);
  $("[data-behavior='unread-count2']").text("Notification(" + UnotifiedCount + ")");
  UnotifiedCount=0;
  return $("[data-behavior='notifications-items']").html(items);
}

notifications()

$(document).on('click', '.notification-box', function (e) {
  let id = $(this).attr('id')
  $.ajax({
    url: `/notifications/${$(this).attr('id')}/mark_one_as_read`,
    dataType: "JSON",
    method: "POST",
    success: function () {
      console.log(id);
      $(`#${id}`).attr('class', 'notification-box');
    }
  });
})


$(document).on('click', '.dropdown-menu', function (e) {
  e.stopPropagation();
});

// setInterval(notifications, 2000);
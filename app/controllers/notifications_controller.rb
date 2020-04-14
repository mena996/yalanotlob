class NotificationsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token


  def index
    @notifications = current_user.notifications.order(created_at: :desc).limit(10)
  end

  def view_all
    @notifications = current_user.notifications.order(created_at: :desc)
  end

  def mark_as_notified
    @notifications = current_user.notifications
    @notifications.update_all(notified: Time.zone.now())
    render json: {success: true}
  end

  def mark_as_read
    @notifications = current_user.notifications.unread
    @notifications.update_all(read_at: Time.zone.now())
    render json: {success: true}
  end

  def mark_one_as_read
    @notification = Notification.find(params[:id])
    @notification.update(read_at: Time.zone.now())
    render json: {success: true}
  end

  
end

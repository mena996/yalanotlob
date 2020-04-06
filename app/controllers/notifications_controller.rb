class NotificationsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: :mark_as_read


  def index
    @notifications = current_user.notifications
  end

  def mark_as_read
    @notifications = current_user.notifications.unread
    @notifications.update_all(read_at: Time.zone.now())
    render json: {success: true}
  end

  
end

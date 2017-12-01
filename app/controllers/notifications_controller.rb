class NotificationController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_user_id_equals_current_user
  before_action :find_notification, only: [:update]
  before_action :find_notifications, only: [:index]

  def index
    raise ActiveRecord::RecordNotFound, "No notification for user found" if @notifications.empty?
    render json: @notifications, status: 200
  end

  def update
    raise ActiveRecord::RecordNotFound, "No notification for user found" if @notification.nil?
    @notification.mark_as_read
    render json: @notification, status: 200
  end

  private
    def find_notification
      @notification = current_user.notifications.find(params[:id])
    end

    def find_notifications
      @notifications = current_user.notifications.all
    end
end

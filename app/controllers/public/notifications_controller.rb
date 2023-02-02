class Public::NotificationsController < ApplicationController
  def index
    @notifications = current_customer.passive_notifications.page(params[:page]).per(20)
    @notifications.where(checked: false).each do |notification|
      notification.checked = true
      notification.save
    end
  end
end

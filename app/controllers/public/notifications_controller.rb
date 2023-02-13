# frozen_string_literal: true

class Public::NotificationsController < ApplicationController
  def index
    @notifications = current_customer.passive_notifications.page(params[:page]).per(20)
    # データを取得した場合、checkedカラムをtrueに変え、保存する
    @notifications.where(checked: false).each do |notification|
      notification.checked = true
      notification.save
    end
  end
end

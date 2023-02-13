# frozen_string_literal: true

class Public::RelationshipsController < ApplicationController
  before_action :authenticate_customer!

  # フォローするとき
  def create
    @customer = Customer.find(params[:customer_id])
    if @customer.id != current_customer.id
      current_customer.follow(params[:customer_id])
      @customer.create_notification_follow!(current_customer)
    end
    redirect_to request.referer
  end

  # フォロー外すとき
  def destroy
    current_customer.unfollow(params[:customer_id])
    redirect_to request.referer
  end

  # フォロー一覧用
  def followings
    @customer = Customer.find(params[:customer_id])
    @customers = @customer.followings
  end

  # フォロワー一覧用
  def followers
    @customer = Customer.find(params[:customer_id])
    @customers = @customer.followers
  end
end

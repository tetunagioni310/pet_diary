# frozen_string_literal: true

class Public::RelationshipsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_customer

  # フォローするとき
  def create
    if @customer.id != current_customer.id
      current_customer.follow(params[:customer_id])
      @customer.create_notification_follow!(current_customer)
    end
    # ralationships/create.js.erbに飛ぶ
  end

  # フォロー外すとき
  def destroy
    current_customer.unfollow(@customer.id)
    # ralationships/destroy.js.erbに飛ぶ
  end

  # フォロー一覧用
  def followings
    # フォローページかどうか
    @followings = true
    @customers = @customer.followings
  end

  # フォロワー一覧用
  def followers
    @customers = @customer.followers
  end
  
  private
  # customer_idから会員を探す
  def set_customer
    @customer = Customer.find(params[:customer_id])
  end
end

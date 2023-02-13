# frozen_string_literal: true

class Public::FavoriteItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @favorite_items = FavoriteItem.where(customer_id: current_customer.id)
  end

  def create
    @favorite_item = FavoriteItem.new
    @favorite_item.customer_id = current_customer.id
    @favorite_items = FavoriteItem.where(customer_id: current_customer.id)
    @favorite_item.favorite_item_name = "アイテム#{@favorite_items.count + 1}"
    @favorite_item.save

    @use_items = UseItem.where(customer_id: current_customer.id)
    @use_items.each do |use_item|
      FavoriteItemDetail.create!(
        favorite_item_id: @favorite_item.id,
        item_id: use_item.item_id,
        amount_used: use_item.amount_used
      )
    end
    redirect_to public_favorite_items_path, notice: "お気に入りアイテムを作成しました。"
  end

  def edit
    @favorite_item = FavoriteItem.find(params[:id])
  end

  def update
    @favorite_item = FavoriteItem.find(params[:id])
    if @favorite_item.update(favorite_item_params)
      @favorite_items = FavoriteItem.where(customer_id: current_customer.id)
      redirect_to public_favorite_items_path, notice: "表示名を変更しました。"
    else
      render "edit"
    end
  end

  def destroy
    @favorite_item = FavoriteItem.find(params[:id])
    @favorite_item.destroy
    redirect_to public_favorite_items_path, notice: "お気に入りアイテムを削除しました。"
  end

  private
    def favorite_item_params
      params.require(:favorite_item).permit(:favorite_item_name)
    end
end

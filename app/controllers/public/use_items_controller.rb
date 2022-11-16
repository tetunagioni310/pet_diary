class Public::UseItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @use_items = UseItem.where(customer_id: current_customer.id)
    @work = Work.new
    @favorite_item = FavoriteItem.new
  end

  def create
    @use_item = UseItem.new(use_item_params)
    @use_item.customer_id = current_customer.id
    if current_customer.use_items.find_by(item_id: params[:use_item][:item_id])
      use_item = current_customer.use_items.find_by(item_id: params[:use_item][:item_id])
      use_item.amount_used += params[:use_item][:amount_used].to_i
      use_item.save
      flash[:notice] = "使用量を追加しました"
      redirect_to public_use_items_path
    else
      @use_item.save
      flash[:notice] = "使用アイテムを追加しました"
      redirect_to public_use_items_path
    end
  end

  def update
    @use_item = UseItem.find(params[:id])
    @use_item.update(use_item_params)
    flash[:notice] = "使用量を変更しました"
    redirect_to public_use_items_path
  end

  def destroy
    @use_item = UseItem.find(params[:id])
    @use_item.destroy
    flash[:notice] = "使用アイテムを削除しました"
    redirect_to public_use_items_path
  end

  def destroy_all
    current_customer.use_items.destroy_all
    flash[:notice] = "使用アイテムを全て削除しました"
    redirect_to public_use_items_path
  end

  private

  def use_item_params
    params.require(:use_item).permit(:item_id,:amount_used)
  end
end

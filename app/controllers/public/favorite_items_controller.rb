class Public::FavoriteItemsController < ApplicationController

  def index
    @favorite_items = FavoriteItem.where(customer_id: current_customer.id)
  end

  def create
    @favorite_item = FavoriteItem.new(favorite_item_params)
    @favorite_item.save
    
    @favorite_item.favorite_item_name = "アイテム" + (@favorite_item.id).to_s
    @favorite_item.save
    
    @use_items = UseItem.where(customer_id: current_customer.id)
    @use_items.each do |use_item|
      @favorite_item_detail = FavoriteItemDetail.new
      @favorite_item_detail.favorite_item_id = @favorite_item.id
      @favorite_item_detail.item_id = use_item.item_id
      @favorite_item_detail.amount_used = use_item.amount_used
      @favorite_item_detail.save
    end
    redirect_to public_use_items_path
  end
  
  def destroy
    @favorite_item = FavoriteItem.find(params[:id])
    @favorite_item.destroy
    redirect_to public_favorite_items_path
  end

  private

  def favorite_item_params
    params.require(:favorite_item).permit(:customer_id)
  end
end

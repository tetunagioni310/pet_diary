class Public::FavoriteItems::UseItemsController < ApplicationController

  def create
    favorite_item = FavoriteItem.find(params[:favorite_item_id])
    favorite_item.favorite_item_details.each do |favorite_item_detail|
      UseItem.create!(
          customer: current_customer,
          item: favorite_item_detail.item,
          amount_used: favorite_item_detail.amount_used
        )
    end
    redirect_to public_use_items_path
  end
end

class Public::FavoriteItems::UseItemsController < ApplicationController
  # お気に入りに登録されているアイテムidを使用アイテムに追加する
  def create
    # 使用アイテムがある時、destroy_allメソッドを実行する
    # [&.]は対象のものがない場合はそのメソッドを実行しない
    current_customer.use_items&.destroy_all if current_customer&.use_items
    favorite_item = FavoriteItem.find(params[:favorite_item_id])
    favorite_item.favorite_item_details.each do |favorite_item_detail|
      UseItem.create!(
        customer: current_customer,
        item: favorite_item_detail.item,
        amount_used: favorite_item_detail.amount_used
      )
    end
    flash[:notice] = 'お気に入りアイテムを呼び出しました'
    redirect_to public_use_items_path
  end
end

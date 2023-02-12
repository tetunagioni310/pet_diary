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
    # ログイン中の会員の使用アイテムの中に既に追加するアイテムidがある時
    if current_customer.use_items.find_by(item_id: params[:use_item][:item_id])
      # 使用アイテムから追加するアイテムidの使用アイテムを取り出し、追加する個数を加算する
      use_item = current_customer.use_items.find_by(item_id: params[:use_item][:item_id])
      if @use_item.amount_used.present?
        use_item.amount_used += params[:use_item][:amount_used].to_i
        use_item.save
        redirect_to public_use_items_path, notice: '使用量を追加しました。'
      else
        @item = Item.find_by(id: params[:use_item][:item_id])
        flash[:notice] = '使用量を入力してください。'
        render template: 'public/items/show'
      end
    else
      if @use_item.amount_used.present?
        @use_item.save
        redirect_to public_use_items_path, notice: '使用アイテムを追加しました。'
      else
        @item = Item.find_by(id: params[:use_item][:item_id])
        flash[:notice] = '使用量を入力してください。'
        render template: 'public/items/show'
      end
    end
  end

  def update
    @use_item = UseItem.find(params[:id])
    @use_item.update(use_item_params)
    redirect_to public_use_items_path, notice: '使用量を変更しました。'
  end
  
  # 一つの使用アイテムを削除
  def destroy
    @use_item = UseItem.find(params[:id])
    @use_item.destroy
    redirect_to public_use_items_path, notice: '使用アイテムを削除しました。'
  end
  
  # 全ての使用アイテムを削除
  def destroy_all
    current_customer.use_items.destroy_all
    redirect_to public_use_items_path, notice: '使用アイテムを全て削除しました。'
  end

  private

  def use_item_params
    params.require(:use_item).permit(:item_id, :amount_used)
  end
end

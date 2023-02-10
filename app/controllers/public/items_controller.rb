class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @item = Item.new
    @items = Item.where(customer_id: current_customer.id)
  end

  def show
    @item = Item.find(params[:id])
    @use_item = UseItem.new
  end

  def create
    @item = Item.new(item_params)
    @item.customer_id = current_customer.id
    # アイテム名と容量が同じ時、既存のアイテムに個数が追加される
    if current_customer.items.find_by(item_name: @item.item_name, capacity: @item.capacity)
      item = current_customer.items.find_by(item_name: @item.item_name, capacity: @item.capacity)
      item.amount += @item.amount
      item.total_capacity += (@item.amount * @item.capacity)
      item.save
      redirect_to public_items_path, notice: '在庫を追加しました。'
      # アイテムの名前・容量・個数のいずれかが空白の場合
    elsif @item.item_name.blank? || @item.capacity.blank? || @item.amount.blank?
      @items = Item.where(customer_id: current_customer.id)
      flash.now[:notice] = '商品名、個数、内容量のいずれかが空欄です。'
      render 'index'
    else
      @item.total_capacity = @item.capacity * @item.amount
      if @item.save
        redirect_to public_items_path, notice: 'アイテムを追加しました。'
      else
        @items = Item.where(customer_id: current_customer.id)
        render 'index'
      end
    end
  end

  def update
    @criterion_vlue = Item.find(params[:id])
    @item = Item.find(params[:id])
    add_item = Item.new(item_params)
    @item.amount += add_item.amount
    @item.total_capacity += @item.capacity * add_item.amount
    @item.save
    flash[:notice] = if @criterion_vlue.amount < @item.amount
                       '在庫を追加しました'
                     else
                       '在庫を減らしました'
                     end
    redirect_to public_items_path
  end
  
  # アラート設定
  def minimum_capacity
    @item = Item.find(params[:item_id])
    @item.update(item_params)
    redirect_to public_item_path(@item.id), notice: '通知を設定しました。'
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to public_items_path, notice: 'アイテムを削除しました。'
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :amount, :capacity, :minimum_capacity, :unit)
  end
end

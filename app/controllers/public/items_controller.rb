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
    if current_customer.items.find_by(item_name: @item.item_name, capacity: @item.capacity)
      item = current_customer.items.find_by(item_name: @item.item_name, capacity: @item.capacity)
      item.amount += @item.amount
      item.total_capacity += ( @item.amount * @item.capacity )
      item.save
      flash[:notice] = "在庫を追加しました"
      redirect_to public_items_path
    else
      if @item.capacity.blank? || @item.amount.blank?
        @items = Item.where(customer_id: current_customer.id)
        render 'index'
      else
        @item.total_capacity = @item.capacity * @item.amount
        if @item.save
          flash[:notice] = "アイテムを追加しました"
          redirect_to public_items_path
        else
          @items = Item.where(customer_id: current_customer.id)
          render 'index'
        end
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
    if @criterion_vlue.amount < @item.amount
      flash[:notice] = "在庫を追加しました"
    else
      flash[:notice] = "在庫を減らしました"
    end
    redirect_to public_items_path
  end
  
  def minimum_capacity
    @item = Item.find(params[:item_id])
    @item.update(item_params)
    flash[:notice] = "通知を設定しました"
    redirect_to public_item_path(@item.id)
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:notice] = "アイテムを削除しました"
    redirect_to public_items_path
  end

  private

  def item_params
    params.require(:item).permit(:item_name,:amount,:capacity,:minimum_capacity,:unit)
  end
end

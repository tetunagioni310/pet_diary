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
    if current_customer.items.find_by(item_name: @item.item_name, capacity: @item.capacity)
      item = current_customer.items.find_by(item_name: @item.item_name, capacity: @item.capacity)
      item.amount += @item.amount
      item.total_capacity += ( @item.amount * @item.capacity )
      item.save
      redirect_to public_items_path
    else
      if @item.capacity != nil or @item.amount != nil
        @item.total_capacity = @item.capacity * @item.amount
        if @item.save
          flash[:notice] = "Item has been registered.."
          redirect_to public_items_path
        else
          @items = Item.where(customer_id: current_customer.id)
          render 'index'
        end
      else
        @items = Item.where(customer_id: current_customer.id)
        render 'index'
      end
    end
  end

  def update
    @item = Item.find(params[:id])
    item = Item.new(item_params)
    @item.amount += item.amount
    @item.total_capacity += @item.capacity * item.amount
    @item.save
    redirect_to public_items_path
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to public_items_path
  end

  private

  def item_params
    params.require(:item).permit(:customer_id,:item_name,:amount,:capacity)
  end
end

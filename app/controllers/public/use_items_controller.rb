class Public::UseItemsController < ApplicationController
  def index
    @use_items = UseItem.where(customer_id: current_customer.id)
  end

  def create
    @use_item = UseItem.new(use_item_params)
    if current_customer.use_items.find_by(item_id: params[:use_item][:item_id])
      use_item = current_customer.use_items.find_by(item_id: params[:use_item][:item_id])
      use_item.amount_used += params[:use_item][:amount_used].to_i
      use_item.save
      redirect_to public_use_items_path
    else
      @use_item.save
      redirect_to public_use_items_path
    end
  end

  def update
    @use_item = UseItem.find(params[:id])
    @use_item.update(use_item_params)
    redirect_to public_use_items_path
  end

  def destroy
    @use_item = UseItem.find(params[:id])
    @use_item.destroy
    redirect_to public_use_items_path
  end

  private

  def use_item_params
    params.require(:use_item).permit(:customer_id,:item_id,:amount_used)
  end
end

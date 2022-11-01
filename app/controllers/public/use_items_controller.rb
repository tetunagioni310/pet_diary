class Public::UseItemsController < ApplicationController
  def index
    @use_items = UseItem.where(customer_id: current_customer.id)
  end
  
  def create
    @use_item = UseItem.new(use_item_params)
    @use_item.save
    redirect_to public_use_items_path
  end
  
  private
  
  def use_item_params
    params.require(:use_item).permit(:customer_id,:item_id,:amount_used)
  end
end

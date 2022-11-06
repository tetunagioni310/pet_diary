class Public::WorksController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @works = Work.where(customer_id: current_customer.id)
  end

  def log
    @work = Work.new(work_params)
    @use_items = UseItem.where(customer_id: current_customer.id)
    if @work.pet_id == nil or @work.work_name == nil
      redirect_to public_use_items_path
    end
  end

  def create
    @work = Work.new(work_params)
    @work.save
    
    use_items = UseItem.where(customer_id: current_customer.id)
    use_items.each do |use_item|
      # work_detail作成
      @work_detail = WorkDetail.new
      @work_detail.item_id = use_item.item_id
      @work_detail.work_id = @work.id
      @work_detail.amount_used = use_item.amount_used
      @work_detail.save
      
      # itemの在庫を変更
      @item = Item.find_by(id: @work_detail.item_id)
      @item.total_capacity -= @work_detail.amount_used
      @item.save
    end
    redirect_to public_works_path
  end

  private

  def work_params
    params.require(:work).permit(:customer_id,:pet_id,:work_name)
  end
end

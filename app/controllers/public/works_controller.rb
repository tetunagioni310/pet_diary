class Public::WorksController < ApplicationController
  before_action :authenticate_customer!

  def new
    @work = Work.new
  end

  def index
    @works = Work.where(customer_id: current_customer.id)
  end

  def show
    @work = Work.find(params[:id])
  end

  def log
    @work = Work.new(work_params)
    @work.customer_id = current_customer.id
    @use_items = current_customer.use_items
    if @work.pet_ids.blank? || @work.work_name.blank?
      render 'new'
    end
  end

  def create
    work_params[:pet_ids].select(&:present?).each do |pet_id|
      @work = Work.new(work_params)
      @work.pet_id = pet_id
      @work.customer_id = current_customer.id
      @work.save!
      use_items = current_customer.use_items
      use_items.each do |use_item|
        # work_detail作成
        @work_detail = WorkDetail.new
        @work_detail.item_id = use_item.item_id
        @work_detail.work_id = @work.id
        @work_detail.amount_used = use_item.amount_used
        @work_detail.save!
  
        # itemの在庫を変更
        @item = Item.find_by(id: @work_detail.item_id)
        @item.total_capacity -= @work_detail.amount_used
        @item.save!
      end
    end
    
    redirect_to public_works_path
  end

  def destroy
    @work = Work.find(params[:id])
    @work.destroy
    redirect_to public_works_path
  end

  private

  def work_params
    params.require(:work).permit(:work_name, pet_ids: [])
  end
end

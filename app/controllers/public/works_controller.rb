class Public::WorksController < ApplicationController
  before_action :authenticate_customer!

  def new
    @work = WorkForm.new
  end

  def index
    @works = Work.where(customer_id: current_customer.id).page(params[:page]).per(10).order(id: "DESC")
  end

  def show
    @work = Work.find(params[:id])
  end

  def log
    @work = WorkForm.new(work_params)
    @work.customer_id = current_customer.id
    @use_items = current_customer.use_items
    if @work.pet_ids.count <= 1 || @work.work_name.blank?
      render 'new'
    end
  end

  def create
    work_params[:pet_ids].select(&:present?).each do |pet_id|
      # formオブジェクト作成
      @work = WorkForm.new(work_params)
      @work.pet_id = pet_id
      @work.customer_id = current_customer.id
      @use_items = current_customer.use_items
      # formオブジェクトから@workに代入してあげないと生成されたidが取得できない
      @work = @work.save!
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
    redirect_to public_works_path, notice: 'ワークを作成しました。'
  end

  def destroy
    @work = Work.find(params[:id])
    @work.destroy
    flash[:notice] = "ワークを削除しました。"
    redirect_to public_works_path
  end

  def search
    @works = Work.pet_work_search(params[:keyword], current_customer).order(id: "DESC").page(params[:page]).per(12)
    @keyword = params[:keyword]
    render "index"
  end

  private

  # pet_ids は配列なので以下の書き方
  def work_params
    params.require(:work_form).permit(:work_name, pet_ids: [])
  end
end

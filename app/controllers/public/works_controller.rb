class Public::WorksController < ApplicationController
  before_action :authenticate_customer!

  def new
    @work = WorkForm.new
  end

  def index
    @works = Work.where(customer_id: current_customer.id).page(params[:page]).per(10).order(id: 'DESC')
  end

  def show
    @work = Work.find(params[:id])
  end

  def log
    @work = WorkForm.new(work_params)
    @work.customer_id = current_customer.id
    @use_items = current_customer.use_items
    # 空白("")がカウントされてしまうので2以上でなければ戻るにしなければならない
    if @work.pet_ids.reject(&:blank?).count <= 0 || @work.work_name.blank?
      flash.now[:notice] = 'ワーク名もしくはペットを選択してください'
      render 'new'
    end

    # アイテムの使用量に対して在庫を確認
    @use_items.each do |use_item|
      item = Item.find_by(id: use_item.item_id)
      if @work.pet_ids.reject(&:blank?).count >= 2
        # ペットが複数の場合は(在庫)と(ペット数×使用量)を比較して在庫が少ない場合はアイテム不足フラグを作成
        if item.total_capacity < use_item.amount_used * (@work.pet_ids.reject(&:blank?).count)
          @missing_item_flag = 1
        end
      else
        if item.total_capacity < use_item.amount_used
          # ペットが単数の場合は(在庫)と(使用量)を比較して在庫が少ない場合はアイテム不足フラグを作成
          @missing_item_flag = 1
        end
      end
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
        @item.amount = @item.total_capacity / @item.capacity
        @item.save!
      end
    end
    redirect_to public_works_path, notice: 'ワークを作成しました。'
  end

  def destroy
    @work = Work.find(params[:id])
    # 在庫を戻す作業
    @work.work_details.each do |work_detail|
      # アイテム情報を取得
      item = Item.find(work_detail.item_id)
      # アイテムの総量に使用量を足す
      item.total_capacity += work_detail.amount_used
      # アイテムの総量から一袋の量を割って袋の量を数える
      item.amount = item.total_capacity / item.capacity
      item.save
    end
    @work.destroy
    redirect_to public_works_path, notice: 'ワークを削除しました。'
  end

  def search
    @works = Work.pet_work_search(params[:keyword], current_customer).order(id: 'DESC').page(params[:page]).per(12)
    @keyword = params[:keyword]
    render 'index'
  end

  private

  # pet_ids は配列なので以下の書き方
  def work_params
    params.require(:work_form).permit(:work_name, pet_ids: [])
  end
end

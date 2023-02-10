class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.all.page(params[:page]).per(10)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  # 会員の状態を「有効」または「退会」状態に変更する
  def update
    @customer = Customer.find(params[:id])
    case @customer.is_deleted
    when false
      @customer.is_deleted = true
      @customer.save
      flash[:notice] = "会員名『#{@customer.nick_name}』を退会にしました"
    when true
      @customer.is_deleted = false
      @customer.save
      flash[:notice] = "会員名『#{@customer.nick_name}』を有効にしました"
    end
    redirect_to admin_customers_path
  end
end

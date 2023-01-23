class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.all.page(params[:page]).per(10)
  end
  
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.is_deleted == false
      @customer.is_deleted = true
      @customer.save
      redirect_to admin_customers_path
    elsif @customer.is_deleted == true
      @customer.is_deleted = false
      @customer.save
      redirect_to admin_customers_path
    end
  end

end

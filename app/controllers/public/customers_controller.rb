class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def member_info
    @posts = Post.where(customer_id: current_customer.id).order(id: "DESC").page(params[:page]).per(10)
  end

  def member_info_edit
     @customer = Customer.find_by(id: current_customer.id)
  end

  def member_info_update
    @customer = Customer.find_by(id: current_customer.id)
    if @customer.update(customer_params)
      @customer.save
      redirect_to member_info_public_customers_path
    else
      render 'member_info_edit'
    end
  end

  def show
    @customer = Customer.find(params[:id])
    @likes = Like.where(customer_id: @customer.id).order(id: "DESC").limit(10)
    @posts = Post.where(customer_id: @customer.id).order(id: "DESC").limit(10)
    @following_customer_posts = Post.where(customer_id: [*current_customer.following_ids]).order(id: "DESC").limit(10)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to public_customer_path(@customer.id)
    else
      render 'edit'
    end
  end

  def quit
  end

  # 会員無効
  def withdrawal
    @customer = Customer.find_by(id: current_customer.id)
    @customer.is_deleted = "true"
    @customer.save
    reset_session
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:email,:nick_name,:introduction,:customer_image)
  end
end

class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def member_info_edit
     @customer = Customer.find_by(id: current_customer.id)
  end

  def member_info_update
    @customer = Customer.find_by(id: current_customer.id)
    if @customer.update(customer_params)
      @customer.save
      redirect_to public_customer_path(@customer.id)
    else
      render 'member_info_edit'
    end
  end

  def show
    @customer = Customer.find(params[:id])
    @likes = Like.where(customer_id: @customer.id).order(id: "DESC").limit(5)
    @posts = Post.where(customer_id: @customer.id).order(id: "DESC").limit(5)
    @following_customer_posts = Post.where(customer_id: [*current_customer.following_ids]).order(id: "DESC").limit(5)
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
    @customer.is_deleted = true
    @customer.save
    reset_session
    redirect_to root_path
  end

  def search_page
  end

  def search
    @customers = Customer.customer_search(params[:keyword]).page(params[:page]).per(10)
    @keyword = params[:keyword]
    render "search_page"
  end

  def pet_index
    @customer = Customer.find(params[:customer_id])
    @pets = Pet.where(customer_id: @customer.id)
  end

  def post_index
    @customer = Customer.find(params[:customer_id])
    @posts = Post.where(customer_id: @customer.id).order(id: "DESC").page(params[:page]).per(10)
  end

  def post_search
    @customer = Customer.find(params[:customer_id])
    customer = @customer
    @posts = Post.other_post_search(params[:keyword], customer).order(id: "DESC").page(params[:page]).per(10)
    @keyword = params[:keyword]
    render "post_index"
  end

  private

  def customer_params
    params.require(:customer).permit(:email,:nick_name,:introduction,:customer_image,:status)
  end
end

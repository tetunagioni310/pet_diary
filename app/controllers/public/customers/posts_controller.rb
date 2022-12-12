class Public::Customers::PostsController < ApplicationController

  def show
    @customer = Customer.find(params[:id])
    @posts = Post.where(customer_id: @customer.id).order(id: "DESC").page(params[:page]).per(10)
  end

  def pet_post_search
    @customer = Customer.find(params[:customer_id])
    customer = @customer
    @posts = Post.pet_post_search(params[:keyword], customer).page(params[:page]).per(10)
    @keyword = params[:keyword]
    render "show"
  end

end
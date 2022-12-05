class Public::Customers::PostsController < ApplicationController

  def show
    @customer = Customer.find(params[:id])
    @posts = Post.where(customer_id: @customer.id).order(id: "DESC").page(params[:page]).per(10)
  end

end
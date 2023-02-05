class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.where(customer_id: params[:customer_id]).order(id: 'DESC').page(params[:page]).per(10)
    @customer = Customer.find(params[:customer_id])
  end

  def show
    @post = Post.find(params[:id])
    @customer = Customer.find_by(id: params[:customer_id])
    @comments = @post.comments.order(id: 'DESC').page(params[:page]).per(5)
  end
  
  def destroy
    post = Post.find(params[:id])
    @customer = post.customer
    @posts = Post.where(customer_id: @customer.id)
    post.destroy
    redirect_to admin_customer_posts_path(@customer.id), notice: "投稿を削除しました"
  end
end

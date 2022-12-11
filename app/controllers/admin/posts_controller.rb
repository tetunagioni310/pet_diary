class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.where(customer_id: params[:customer_id]).order(id: "DESC").page(params[:page]).per(10)
    @customer = Customer.find(params[:customer_id])
  end

  def show
    @post = Post.find(params[:id])
    @customer = Customer.find_by(id: params[:customer_id])
    @comments = Comment.where(post_id: @post.id).order(id: "DESC").page(params[:page]).per(10)
  end
end

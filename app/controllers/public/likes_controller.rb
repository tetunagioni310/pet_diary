class Public::LikesController < ApplicationController
  before_action :authenticate_customer!

  def create
    @post = Post.find(params[:post_id])
    if @post.customer_id != current_customer.id
      @like = current_customer.likes.create(post_id: params[:post_id])
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @like = Like.find_by(post_id: params[:post_id], customer_id: current_customer.id)
    @like.destroy
    redirect_back(fallback_location: root_path)
  end

end

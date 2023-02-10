class Public::LikesController < ApplicationController
  before_action :authenticate_customer!

  def create
    post = Post.find(params[:post_id])
    # 投稿者の会員idと現在ログインしている会員idが違うなら
    if post.customer_id != current_customer.id
      # ログイン中の会員が投稿にいいねをする
      current_customer.likes.create(post_id: params[:post_id])
      # 通知レコードを作成
      post.create_notification_like!(current_customer)
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = Like.find_by(post_id: params[:post_id], customer_id: current_customer.id)
    @like.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end
end

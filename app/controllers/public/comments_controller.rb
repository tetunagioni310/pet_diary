class Public::CommentsController < ApplicationController
  before_action :authenticate_customer!

  # コメント作成
  def create
    @comment = current_customer.comments.new(comment_params)
    @post = @comment.post
    @comment.save
    @post.create_notification_comment!(current_customer, @comment.id)
    redirect_back(fallback_location: root_path)
  end

  # コメントの編集
  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @customer = Customer.find_by(id: @post.customer_id)
  end

  # コメントの更新
  def update
    @comment = Comment.find_by(id: params[:id])
    @post = @comment.post
    @comment.update(comment_params)
    redirect_to public_post_path(@post.id)
  end

  # コメントの削除
  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    flash[:notice] = 'コメントを削除しました'
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content, :post_id)
  end
end

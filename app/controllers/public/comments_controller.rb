class Public::CommentsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @comment = current_customer.comments.new(comment_params)
    @post = @comment.post
    @comment.save
    @post.create_notification_comment!(current_customer, @comment.id)
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    flash[:notice] = "コメントを削除しました"
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content, :post_id)
  end
end

class Public::CommentsController < ApplicationController
  before_action :authenticate_customer!
  
  def create
    @comment = current_customer.comments.new(comment_params)
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:comment_content,:post_id)
  end
end

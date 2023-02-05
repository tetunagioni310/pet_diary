class Admin::Customers::Posts::CommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def destroy
    comment = Comment.find(params[:id])
    post = comment.post
    @customer = Customer.find_by(id: post.customer_id)
    comment.destroy
    redirect_to admin_customer_post_path(@customer.id,post.id), notice: "コメントを削除しました"
  end
end
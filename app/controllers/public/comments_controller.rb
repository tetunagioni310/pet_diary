# frozen_string_literal: true

class Public::CommentsController < ApplicationController
  before_action :authenticate_customer!
  before_action :correct_customer, only: %i[edit update destroy]

  # コメント作成
  def create
    @comment = current_customer.comments.new(comment_params)
    @post = @comment.post
    if @comment.save
      @post.create_notification_comment!(current_customer, @comment.id)
      flash[:notice] = "コメントを作成しました。"
      redirect_back(fallback_location: root_path)
    else
      flash.now[:notice] = "コメントを入力してください。"
      @comments = @post.comments.order(id: "DESC").page(params[:page]).per(5)
      @comment = current_customer.comments.new
      @like = Like.new
      render template: "public/posts/show"
    end
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
    redirect_to public_post_path(@post.id), notice: "コメントを更新しました。"
  end

  # コメントの削除
  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    flash[:notice] = "コメントを削除しました"
    redirect_back(fallback_location: root_path)
  end

  

  private
    
    def correct_customer
      @comment = Comment.find(params[:id])
      @customer = @comment.customer
      return unless @customer.id != current_customer.id
      redirect_to public_post_path(@comment.post.id), notice: "管理者が違います。"
    end
  
    def comment_params
      params.require(:comment).permit(:comment_content, :post_id)
    end
end

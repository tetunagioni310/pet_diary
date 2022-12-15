class Public::PostsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @posts = Post.where(customer_id: current_customer.id).order(id: "DESC").page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = current_customer.comments.new
    @like = Like.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      flash[:notice] = "投稿を作成しました"
      redirect_to public_post_path(@post.id)
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿を更新しました"
      redirect_to public_posts_path
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to public_posts_path
  end

  def all
    @posts = Post.all.order(id: "DESC").page(params[:page]).per(8)
  end

  def search
    @posts = Post.my_post_search(params[:keyword], current_customer).order(id: "DESC").page(params[:page]).per(10)
    @keyword = params[:keyword]
    render "index"
  end

  private

  def post_params
    params.require(:post).permit(:pet_id,:post_title,:post_content,:post_image,:start_time)
  end
end

class Public::PostsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @posts = Post.where(customer_id: current_customer.id)
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
    if @post.save
      redirect_to public_posts_path
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
      redirect_to public_posts_path
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to public_posts_path
  end

  def search
    @posts = Post.search(params[:keyword], current_customer)
    @keyword = params[:keyword]
    render "index"
  end

  private

  def post_params
    params.require(:post).permit(:customer_id,:pet_id,:post_title,:post_content,:post_image,:start_time)
  end
end

class Public::PostsController < ApplicationController
  before_action :authenticate_customer!
  before_action :correct_customer, only: %i[edit update destroy]

  def index
    @posts = Post.where(customer_id: current_customer.id).order(id: 'DESC').page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.order(id: 'DESC').page(params[:page]).per(5)
    @comment = current_customer.comments.new
    @like = Like.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    @pet = Pet.find_by(id: @post.pet_id)
    if @post.save
      redirect_to public_post_path(@post.id), notice: '投稿を作成しました。'
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
      redirect_to public_post_path(@post.id), notice: '投稿を更新しました。'
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to public_posts_path, notice: '投稿を削除しました。'
  end

  # def post_all_prototype
  #   @post_all = Post.released_post
  #   @posts = Post.released_post.order(id: 'DESC').page(params[:posts_page]).per(8)
  #   groups = Group.all
  #   groups.each do |group|
  #     case group.group_name
  #     when '犬'
  #       @dog_post_all = Post.released_post_group(group)
  #       @dog_posts = Post.released_post_group(group).order(id: 'DESC').page(params[:dog_posts_page]).per(8)
  #     when '猫'
  #       @cat_post_all = Post.released_post_group(group)
  #       @cat_posts = Post.released_post_group(group).order(id: 'DESC').page(params[:cat_posts_page]).per(8)
  #     when 'その他'
  #       @other_post_all = Post.released_post_group(group)
  #       @other_posts = Post.released_post_group(group).order(id: 'DESC').page(params[:other_posts_page]).per(8)
  #     end
  #   end
  # end
  
  def post_all
    @post_all = Post.released_post
    @posts = Post.released_post.order(id: 'DESC').page(params[:posts_page]).per(8)
    groups = Group.all
    groups.each do |group|
      case group.group_name
      when '犬'
        @dog_group = group
      when '猫'
        @cat_group = group
      when 'その他'
        @other_group = group 
      end
    end
  end

  def search
    @posts = Post.my_post_search(params[:keyword], current_customer).order(id: 'DESC').page(params[:page]).per(12)
    @keyword = params[:keyword]
    render 'index'
  end

  def search_all
    @post_all = Post.all_post_search(params[:keyword])
    @posts = Post.all_post_search(params[:keyword]).order(id: 'DESC').page(params[:page]).per(12)
    @keyword = params[:keyword]
    render 'post_all'
  end

  def correct_customer
    post = Post.find(params[:id])
    customer = Customer.find_by(id: post.customer_id)
    return unless customer.id != current_customer.id

    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:pet_id, :post_title, :post_content, :post_image)
  end
end

class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
   # ゲストユーザーの更新・削除・退会を無効
  before_action :ensure_normal_customer, only: [:destroy,:update,:withdrawal]
  before_action :correct_customer, only: [:edit,:update,:introduction_edit,:introduction_update]

  # 会員情報編集
  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to public_customer_path(@customer.id), notice: '会員情報を更新しました。'
    else
      render 'edit'
    end
  end

  # 自己紹介コメント編集
  def introduction_edit
     @customer = Customer.find_by(id: current_customer.id)
  end

  def introduction_update
    @customer = Customer.find_by(id: current_customer.id)
    if @customer.update(customer_params)
      redirect_to public_customer_path(@customer.id), notice: 'コメントを更新しました。'
    else
      render 'introduction_edit'
    end
  end

  def show
    @customer = Customer.find(params[:id])
    # POSTテーブルと結合して公開状態の投稿を取得
    @like_posts = Post.joins(:likes,:customer).where(likes: { customer_id: @customer.id },customers: { status: 1 }).order(id: 'DESC').limit(5)
    @posts = Post.where(customer_id: @customer.id).order(id: 'DESC').limit(5)
    @following_customer_posts = Post.joins(:customer).where(posts: {customer_id: [*@customer.following_ids]}, customers: { status: 1 }).order(id: 'DESC').limit(5)
  end


  def quit
  end

  # 会員無効
  def withdrawal
    @customer = Customer.find_by(id: current_customer.id)
    @customer.is_deleted = true
    @customer.save
    reset_session
    redirect_to root_path
  end

  def search_page
  end

  # 会員検索
  def search
    @customers = Customer.customer_search(params[:keyword]).page(params[:page]).per(10)
    @keyword = params[:keyword]
    render 'search_page'
  end

  def pet_index
    @customer = Customer.find(params[:customer_id])
    @pets = Pet.where(customer_id: @customer.id)
  end

  def post_index
    @customer = Customer.find(params[:customer_id])
    @posts = Post.where(customer_id: @customer.id).order(id: 'DESC').page(params[:page]).per(10)
  end

  def post_search
    @customer = Customer.find(params[:customer_id])
    customer = @customer
    @posts = Post.other_post_search(params[:keyword], customer).order(id: 'DESC').page(params[:page]).per(10)
    @keyword = params[:keyword]
    render 'post_index'
  end

   # ゲストログイン中にはセッションを消去できない
  def ensure_normal_customer
    if !admin_signed_in?
      @customer = Customer.find(current_customer.id)
      if @customer.email == 'guest@example.com'
        redirect_to root_path, notice: 'ゲスト ユーザーは更新・削除できません'
      end
    end
  end
  
  def correct_customer
    customer = Customer.find(params[:id])
    if customer != current_customer
      redirect_to root_path
    end
  end
  
  private

  def customer_params
    params.require(:customer).permit(:email,:nick_name,:introduction,:customer_image,:status)
  end
end

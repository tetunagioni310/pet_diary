class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  # ゲストユーザーの更新・削除・退会を無効
  before_action :ensure_normal_customer, only: %i[destroy update withdrawal]
  before_action :correct_customer, only: %i[edit update]

  # 会員情報編集
  def edit
    @customer = Customer.find(params[:id])
  end

  # 会員情報を更新
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to public_customer_path(@customer.id), notice: '会員情報を更新しました。'
    else
      render 'edit'
    end
  end

  # 自己紹介文編集
  def introduction_edit
    @customer = Customer.find_by(id: current_customer.id)
  end

  # 自己紹介文更新
  def introduction_update
    @customer = Customer.find_by(id: current_customer.id)
    if @customer.update(customer_params)
      redirect_to public_customer_path(@customer.id), notice: '紹介文を更新しました。'
    else
      render 'introduction_edit'
    end
  end

  # 会員ページ表示
  def show
    @customer = Customer.find(params[:id])
    # POSTテーブルと結合して公開状態の投稿を取得
    @like_posts = Post.joins(:likes, :customer).where(likes: { customer_id: @customer.id },
                                                      customers: { status: 1 }).order(id: 'DESC').limit(5)
    @posts = Post.where(customer_id: @customer.id).order(id: 'DESC').limit(5)
    @following_customer_posts = Post.joins(:customer).where(posts: { customer_id: [*@customer.following_ids] },
                                                            customers: { status: 1 }).order(id: 'DESC').limit(5)
  end

  # 退会確認画面
  def quit; end

  # 会員無効
  def withdrawal
    @customer = Customer.find_by(id: current_customer.id)
    @customer.is_deleted = true
    @customer.save
    reset_session
    redirect_to root_path
  end

  def search_page; end

  # 会員検索
  def search
    @customers = Customer.customer_search(params[:keyword]).page(params[:page]).per(10)
    @keyword = params[:keyword]
    render 'search_page'
  end

  # 会員別のペット一覧
  def pet_index
    @customer = Customer.find(params[:customer_id])
    @pets = Pet.where(customer_id: @customer.id)
  end

  # 会員別の投稿一覧
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

  # ゲストログイン中に更新・削除ができない
  def ensure_normal_customer
    return if admin_signed_in?

    @customer = Customer.find(current_customer.id)
    return unless @customer.email == 'guest@example.com'

    redirect_to root_path, notice: 'ゲスト ユーザーは更新・削除できません'
  end

  # 正しい会員じゃない場合、ルートパスへ遷移する
  def correct_customer
    customer = Customer.find(params[:id])
    return unless customer != current_customer
    redirect_to root_path, notice: '管理者が違います。'
  end

  private

  def customer_params
    params.require(:customer).permit(:email, :nick_name, :introduction, :customer_image, :status)
  end
end

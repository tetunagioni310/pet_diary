class ApplicationController < ActionController::Base
  # ゲストログインをログアウトする時は以下を無効にする
  before_action :ensure_normal_customer, only: [:destroy,:update,:member_info_update,:withdrawal]

  # ゲストログイン中にはセッションを消去できない
  def ensure_normal_customer
    if !admin_signed_in?
      @customer = Customer.find(current_customer.id)
      if @customer.email == 'guest@example.com'
        redirect_to root_path, notice: 'ゲスト ユーザーは更新・削除できません'
      end
    end
  end

  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました'
  end

end

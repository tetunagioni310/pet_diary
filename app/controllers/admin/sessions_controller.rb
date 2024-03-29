# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #     super
  # end

  protected
    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end

    # 管理者ログインした後、管理者トップ画面へ遷移する
    def after_sign_in_path_for(_resource)
      admin_homes_top_path
    end

    # 管理者ログアウトした後、管理者ログイン画面へ遷移する
    def after_sign_out_path_for(_resource)
      new_admin_session_path
    end
end

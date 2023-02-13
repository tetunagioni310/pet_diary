# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # ゲストでサインインする
  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to public_customer_path(customer.id), notice: "ゲストユーザーとしてログインしました"
  end
end

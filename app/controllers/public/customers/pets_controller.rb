class Public::Customers::PetsController < ApplicationController
  # 会員別のペット一覧
  def show
    @customer = Customer.find(params[:id])
    @pets = Pet.where(customer_id: @customer.id)
  end
end

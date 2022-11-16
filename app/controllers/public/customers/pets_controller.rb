class Public::Customers::PetsController < ApplicationController
  
  def show
    @customer = Customer.find(params[:id])
    @pets = Pet.where(customer_id: @customer.id)
  end
end
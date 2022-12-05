class Public::Pets::PostsController < ApplicationController

  def show
    @pet = Pet.find(params[:id])
    @customer = Customer.find_by(id: @pet.customer.id)
    @posts = Post.where(pet_id: @pet.id).order(id: "DESC").page(params[:page]).per(10)
  end

end
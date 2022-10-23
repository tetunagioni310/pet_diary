class Public::PetsController < ApplicationController

  def index
    @pets = Pet.where(customer_id: current_customer.id)
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    if @pet.save
      redirect_to public_pets_path
    else
      render "new"
    end
  end

  private

  def pet_params
    params.require(:pet).permit(:pet_name,:pet_introduction,:gender,:age,:pet_image,:customer_id,:group_id,:birthday)
  end
end

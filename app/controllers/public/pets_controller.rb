class Public::PetsController < ApplicationController

  def index
    @pets = Pet.where(customer_id: current_customer.id)
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @pet = Pet.new
    @gender_array = [1, 2]
  end

  def create
    @pet = Pet.new(pet_params)
    if @pet.save
      redirect_to public_pets_path
    else
      render "new"
    end
  end
  
  def edit
    @pet = Pet.find(params[:id])
  end
  
  def update
    @pet = Pet.find(params[:id])
    if @pet.update(pet_params)
      redirect_to public_pet_path(@pet.id)
    else
      render 'edit'
    end
  end

  private

  def pet_params
    params.require(:pet).permit(:pet_name,:pet_introduction,:gender,:age,:pet_image,:customer_id,:group_id,:birthday)
  end
end

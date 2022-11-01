class Public::PetsController < ApplicationController

  def index
    @customer = Customer.find_by(id: current_customer.id)
    @pets = Pet.where(customer_id: @customer.id)
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

  def destroy
    @pet = Pet.find(params[:id])
    @pet.destroy
    redirect_to public_pets_path
  end

  private

  def pet_params
    params.require(:pet).permit(:pet_name,:pet_introduction,:gender,:age,:pet_image,:customer_id,:group_id,:birthday)
  end
end
class Public::ExpendablesController < ApplicationController
  def index
    @pet = Pet.find(params[:pet_id])
    @expendable = Expendable.new
    @expendables = Expendable.where(pet_id: @pet.id)
  end

  def show
  end

  def edit
  end
  
end

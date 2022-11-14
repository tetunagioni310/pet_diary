class Public::Pets::WorksController < ApplicationController
  
  def show
    @pet = Pet.find(params[:id])
    @works = Work.where(pet_id: @pet.id)
  end
end
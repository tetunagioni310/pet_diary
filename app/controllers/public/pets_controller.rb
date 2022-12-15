class Public::PetsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @customer = Customer.find_by(id: current_customer.id)
    @pets = Pet.where(customer_id: @customer.id)
  end

  def work_index
    @pet = Pet.find(params[:pet_id])
    @works = Work.where(pet_id: @pet.id)
  end

  def post_index
    @pet = Pet.find(params[:pet_id])
    @customer = Customer.find_by(id: @pet.customer.id)
    @posts = Post.where(pet_id: @pet.id).order(id: "DESC").page(params[:page]).per(10)
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
    @pet.customer_id = current_customer.id
    if @pet.save
      flash[:notice] = "ペットを追加しました"
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
      flash[:notice] = "ペット情報を更新しました"
      redirect_to public_pet_path(@pet.id)
    else
      render 'edit'
    end
  end

  def destroy
    @pet = Pet.find(params[:id])
    @pet.destroy
    flash[:notice] = "登録ペットを削除しました"
    redirect_to public_pets_path
  end

  private

  def pet_params
    params.require(:pet).permit(:pet_name,:pet_introduction,:gender,:age,:pet_image,:group_id,:pet_type,:birthday)
  end
end

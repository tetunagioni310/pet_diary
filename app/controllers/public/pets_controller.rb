class Public::PetsController < ApplicationController
  before_action :authenticate_customer!
  before_action :correct_customer, only: %i[edit update destroy]

  def index
    @customer = Customer.find_by(id: current_customer.id)
    @pets = Pet.where(customer_id: @customer.id)
  end
  
  # ペット用のワーク一覧
  def work_index
    @pet = Pet.find(params[:pet_id])
    @works = Work.where(pet_id: @pet.id).page(params[:page]).per(10).order(id: 'DESC')
  end
  
  # ペット用の投稿一覧
  def post_index
    @pet = Pet.find(params[:pet_id])
    @customer = Customer.find_by(id: @pet.customer.id)
    @posts = Post.where(pet_id: @pet.id).order(id: 'DESC').page(params[:page]).per(10)
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
      redirect_to public_pets_path, notice: 'ペットを追加しました。'
    else
      render 'new'
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    @pet = Pet.find(params[:id])
    if @pet.update(pet_params)
      redirect_to public_pet_path(@pet.id), notice: 'ペット情報を更新しました。'
    else
      render 'edit'
    end
  end

  def destroy
    @pet = Pet.find(params[:id])
    @pet.destroy
    redirect_to public_pets_path, notice: '登録ペットを削除しました。'
  end
  
  # ペットの会員idがログイン中の会員idと一致しない時にルートページへ遷移
  def correct_customer
    pet = Pet.find(params[:id])
    customer = Customer.find_by(id: pet.customer_id)
    return unless customer.id != current_customer.id
    redirect_to root_path, notice: '管理者が違います。'
  end

  private

  def pet_params
    params.require(:pet).permit(:pet_name, :pet_introduction, :gender, :pet_image, :group_id, :pet_kind, :birthday)
  end
end

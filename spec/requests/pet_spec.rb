# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Pets" do
  let! (:customer)  { create(:customer) }
  let! (:customer2)  { create(:customer) }
  
  describe "ペットに関する画像遷移" do
    before do
      sign_in customer
    end
    
    it "ペット一覧へアクセスできる" do
      get public_pets_path customer
      expect(response).to have_http_status(:success)
    end
 
    it "ペット新規投稿画面へアクセスできる" do
      get public_pets_path
      get new_public_pet_path
      expect(response).to have_http_status(:success)
    end
    
    it "ペット詳細画面及び編集画面へアクセスできる" do
      @pet = FactoryBot.create(:pet)
      @pet.customer = customer
      @pet.save
      get public_pet_path(@pet.id)
      expect(response).to have_http_status(:success)
      get edit_public_pet_path(@pet.id)
      expect(response).to have_http_status(:success)
    end
  end
  
  
  describe "ペットの飼い主ではない場合" do
    context "画像遷移" do
        
      it "ルートページへ飛ばされる" do
        sign_in customer
        @pet = FactoryBot.create(:pet)
        @pet.customer = customer
        @pet.save
        sign_out customer
        sign_in customer2
        get edit_public_pet_path(@pet.id)
        expect(response).to redirect_to root_path
      end
    end
  end
  
  # describe "ペット" do
  #   context "本人ではない場合" do
  #     it "Homeにリダイレクトされる" do
  #     end
  #   end
  # end
  
  
end

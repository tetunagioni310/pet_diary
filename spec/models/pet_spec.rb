# frozen_string_literal: true

require "rails_helper"

RSpec.describe Pet, type: :model do
  describe "ペット登録" do
    before do
      @dog = create(:pet)
    end

    it "有効なペット情報記述し、グループ「犬」を選択した場合、登録されるか" do
      expect(@dog).to be_valid  # pet.valid? が true になればパスする
    end

    it "有効なペット情報記述し、グループ「猫」を選択した場合、登録されるか" do
      @cat = create(:pet, :cat_group)
      expect(@cat).to be_valid  # pet.valid? が true になればパスする
    end

    it "有効なペット情報記述し、グループ「その他」を選択した場合、登録されるか" do
      @other = create(:pet, :other_group)
      expect(@other).to be_valid  # pet.valid? が true になればパスする
    end

    it "pet_nameが空欄の場合、登録できない" do
      @dog.pet_name = nil
      @dog.valid?
      expect(@dog.errors.full_messages).to include("ペット名を入力してください")
    end

    it "pet_nameが9文字以上の場合、登録できない" do
      @dog.pet_name = "あ" * 9
      @dog.valid?
      expect(@dog.errors.full_messages).to include("ペット名は8文字以内で入力してください")
    end

    it "genderが空欄の場合、登録できない" do
      @dog.gender = nil
      @dog.valid?
      expect(@dog.errors.full_messages).to include("性別を入力してください")
    end

    it "birthdayが空欄の場合、登録できない" do
      @dog.birthday = nil
      @dog.valid?
      expect(@dog.errors.full_messages).to include("誕生日を入力してください")
    end
  end
end

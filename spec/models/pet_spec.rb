require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'ペット登録' do
    it '有効なペット情報記述し、グループ「犬」を選択したの場合データが保存されるか' do
      expect(FactoryBot.create(:pet)).to be_valid  # pet.valid? が true になればパスする
    end
    
    it '有効なペット情報記述し、グループ「猫」を選択したの場合データが保存されるか' do
      expect(FactoryBot.create(:pet, :cat_group)).to be_valid  # pet.valid? が true になればパスする
    end
    
    it '有効なペット情報記述し、グループ「その他」を選択したの場合データが保存されるか' do
      expect(FactoryBot.create(:pet, :other_group)).to be_valid  # pet.valid? が true になればパスする
    end
  end
end

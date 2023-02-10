require 'rails_helper'

RSpec.describe UseItem, type: :model do
  describe '使用アイテム登録' do
    it '有効な使用アイテムの場合は保存されるか' do
      expect(FactoryBot.create(:use_item)).to be_valid  # pet.valid? が true になればパスする
    end
  end
end
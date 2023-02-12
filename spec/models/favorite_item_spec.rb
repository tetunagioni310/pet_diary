require 'rails_helper'

RSpec.describe FavoriteItem, type: :model do
  describe 'お気に入りアイテム登録' do
    before do
      @favorite_item = create(:favorite_item)
    end
    
    it '有効なお気に入りアイテムの場合は保存されるか' do
      expect(@favorite_item).to be_valid  # pet.valid? が true になればパスする
    end
    
    it 'favorite_item_nameが空欄の場合、保存されない' do
      @favorite_item.favorite_item_name = ''
      @favorite_item.valid?
      expect(@favorite_item.errors.full_messages).to include('表示名を入力してください')
    end
  end
end
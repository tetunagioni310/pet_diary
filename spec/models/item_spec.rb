require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'アイテム登録' do
    before do
      @item = create(:item)
    end
    
    it 'item_name、amount、capacity、unitが存在すれば登録できること' do
      expect(@item).to be_valid  # item.valid? が true になればパスする
    end
    
    it 'item_nameが空欄の場合、登録できない' do
      @item.item_name = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('アイテム名を入力してください')
    end
    
    it 'item_nameが21文字以上の場合、登録できない' do
      @item.item_name = "あ" * 21
      @item.valid?
      expect(@item.errors.full_messages).to include('アイテム名は20文字以内で入力してください')
    end
    
    it 'amountが空欄の場合、登録できない' do
      @item.amount = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('個数を入力してください')
    end
    
    it 'capacityが空欄の場合、登録できない' do
      @item.capacity = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('容量を入力してください')
    end
  end
end

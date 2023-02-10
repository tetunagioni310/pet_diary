require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'アイテム登録' do
    it 'name、email、passwordとpassword_confirmationが存在すれば登録できること' do
      expect(FactoryBot.create(:item)).to be_valid  # item.valid? が true になればパスする
    end
  end
end

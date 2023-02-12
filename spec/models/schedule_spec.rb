require 'rails_helper'

RSpec.describe Schedule, type: :model do
  describe 'ペット登録' do
    it '有効なペット情報の場合は保存されるか' do
      expect(FactoryBot.create(:schedule)).to be_valid  # schedule.valid? が true になればパスする
    end
  end
end
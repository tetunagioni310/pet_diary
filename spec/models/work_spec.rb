require 'rails_helper'

RSpec.describe Work, type: :model do
  describe 'ワークを作成する' do
    it '有効な情報を登録すればワークを作成できること' do
      expect(FactoryBot.create(:work)).to be_valid  # comment.valid? が true になればパスする
    end
    
    
  end
end
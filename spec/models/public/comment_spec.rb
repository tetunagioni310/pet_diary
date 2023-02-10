require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '投稿にコメントをする' do
    it 'name、email、passwordとpassword_confirmationが存在すれば登録できること' do
      expect(FactoryBot.create(:comment)).to be_valid  # comment.valid? が true になればパスする
    end
  end
end
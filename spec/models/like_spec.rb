require 'rails_helper'

RSpec.describe Like, type: :model do
  describe '投稿にいいねする' do
    it '投稿にいいねが可能か' do
      expect(FactoryBot.create(:like)).to be_valid  # pet.valid? が true になればパスする
    end
  end
end
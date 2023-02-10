require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe '会員登録' do
    it 'name、email、passwordとpassword_confirmationが存在すれば登録できること' do
      expect(FactoryBot.create(:customer)).to be_valid  # user.valid? が true になればパスする
    end
  end
end

require 'rails_helper'

RSpec.describe Customer, type: :model do
  
  describe '会員登録' do
    before do
      @customer = build(:customer)
    end
    
    it '必要情報が揃っていれば登録できる' do
      expect(@customer).to be_valid  # customer.valid? が true になればパスする
    end

    it 'nick_nameが空だと登録できない' do
      @customer.nick_name = nil
      @customer.valid?
      # valid? を実行すると[errors.full_messages]にエラーメッセージが格納される
      expect(@customer.errors.full_messages).to include('ニックネームを入力してください')
    end
    
    it 'nick_nameが16文字以上だと登録できない' do
      @customer.nick_name = 'あ' * 16
      @customer.valid?
      expect(@customer.errors.full_messages).to include('ニックネームは15文字以内で入力してください')
    end
    
    it 'emailが空だと登録できない' do
      @customer.email = nil
      @customer.valid?
      expect(@customer.errors.full_messages).to include('メールアドレスを入力してください')
    end
    
    it 'emailに一意性がないと登録できない' do
      @customer.save
      another_customer = build(:customer, email: @customer.email)
      another_customer.valid?
      expect(another_customer.errors.full_messages).to include('メールアドレスはすでに存在します')
    end
    
    it 'introductionが301文字以上なら登録できない' do
      @customer.introduction = 'あ' * 301
      @customer.valid?
      expect(@customer.errors.full_messages).to include('紹介文は300文字以内で入力してください')
    end
 end
end

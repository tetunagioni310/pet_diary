require  'rails_helper'

RSpec.describe Public::SessionsController, type: :controller do

  let(:customer) { create(:customer) }
  # customerをcreateし、let内に格納

  describe '会員がログインした時' do
    before do
      login_customer customer
      # controller_macros.rb内のlogin_customerメソッドを呼び出し
    end

    it "会員がログインした時、会員詳細画面が表示される" do
    end
  end
end

RSpec.describe Admin::SessionsController, type: :controller do

  let(:admin) { create(:admin) }

  describe '管理者ログイン' do
    before do
      login_admin admin
      # controller_macros.rb内のlogin_adminメソッドを呼び出し
    end

    it "管理者がログインした時、管理者トップ画面が表示される" do
    end
  end
end
require  'rails_helper'

RSpec.describe Public::SessionsController, type: :controller do

  let(:customer) { create(:customer) }
  # customerをcreateし、let内に格納

  describe 'ログインした時、会員詳細画面へ遷移する' do
    before do
      login_customer customer
      # controller_macros.rb内のlogin_customerメソッドを呼び出し
    end

    it "renders the :show template" do
      public_customer_path(customer.id)
    end
  end
end
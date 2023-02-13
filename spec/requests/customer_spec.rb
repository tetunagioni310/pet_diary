# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Customers" do
  let! (:customer)  { build(:customer) }
  let! (:customer2) { build(:customer) }

  describe "会員情報編集画面" do
    context "本人ではない場合" do
      before do
        sign_in customer2
        get edit_public_customer_path customer
      end

      it "Homeにリダイレクトされる" do
        expect(response).to redirect_to root_path
      end
    end
  end

  it "ログインしてる時、ユーザーの詳細ページにアクセスできる" do
    sign_in customer
    get public_customer_path customer
    expect(response).to have_http_status(200)
  end
end

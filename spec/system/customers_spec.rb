# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Customers", type: :system do
  let!(:customer) { create(:customer) }

  describe "ログイン前" do
    describe "ユーザー新規登録" do
      context "ユーザーの新規作成が成功する" do
        it "ユーザーの新規作成が成功する" do
          visit new_customer_registration_path
          fill_in "customer[nick_name]", with: "nick_name"
          fill_in "customer[email]", with: "email@test.com"
          fill_in "customer[password]", with: "password"
          fill_in "customer[password_confirmation]", with: "password"
          click_button "新規登録"
          expect(current_path).to eq public_customer_path(2)
          expect(page).to have_content "アカウント登録が完了しました。"
        end
      end

      context "ユーザーの新規作成が失敗する" do
        it "[ニックネーム]が16文字以上" do
          visit new_customer_registration_path
          fill_in "customer[nick_name]", with: "testtesttesttesttesttesttesttest"
          fill_in "customer[email]", with: "email@test.com"
          fill_in "customer[password]", with: "password"
          fill_in "customer[password_confirmation]", with: "password"
          click_button "新規登録"
          expect(current_path).to eq customer_registration_path
          expect(page).to have_content "ニックネームは15文字以内で入力してください"
        end

        it "[ニックネーム]が未入力" do
          visit new_customer_registration_path
          fill_in "customer[nick_name]", with: ""
          fill_in "customer[email]", with: "email@test.com"
          fill_in "customer[password]", with: "password"
          fill_in "customer[password_confirmation]", with: "password"
          click_button "新規登録"
          expect(current_path).to eq customer_registration_path
          expect(page).to have_content "ニックネームを入力してください"
        end

        it "[メールアドレス]が未入力" do
          visit new_customer_registration_path
          fill_in "customer[nick_name]", with: "nick_name"
          fill_in "customer[email]", with: ""
          fill_in "customer[password]", with: "password"
          fill_in "customer[password_confirmation]", with: "password"
          click_button "新規登録"
          expect(current_path).to eq customer_registration_path
          expect(page).to have_content "メールアドレスを入力してください"
        end

        it "[パスワード]と[パスワード確認]が未入力" do
          visit new_customer_registration_path
          fill_in "customer[nick_name]", with: "nick_name"
          fill_in "customer[email]", with: "email@test.com"
          fill_in "customer[password]", with: ""
          fill_in "customer[password_confirmation]", with: ""
          click_button "新規登録"
          expect(current_path).to eq customer_registration_path
          expect(page).to have_content "パスワードを入力してください"
        end

        it "[パスワード]が未記入" do
          visit new_customer_registration_path
          fill_in "customer[nick_name]", with: "nick_name"
          fill_in "customer[email]", with: "email@test.com"
          fill_in "customer[password]", with: ""
          fill_in "customer[password_confirmation]", with: "password"
          click_button "新規登録"
          expect(current_path).to eq customer_registration_path
          expect(page).to have_content "パスワード確認とパスワードの入力が一致しません"
        end

        it "[パスワード]が6文字未満" do
          visit new_customer_registration_path
          fill_in "customer[nick_name]", with: "nick_name"
          fill_in "customer[email]", with: "email@test.com"
          fill_in "customer[password]", with: "passw"
          fill_in "customer[password_confirmation]", with: "passw"
          click_button "新規登録"
          expect(current_path).to eq customer_registration_path
          expect(page).to have_content "パスワードは6文字以上で入力してください"
        end

        it "[パスワード確認]が未記入" do
          visit new_customer_registration_path
          fill_in "customer[nick_name]", with: "nick_name"
          fill_in "customer[email]", with: "email@test.com"
          fill_in "customer[password]", with: "password"
          fill_in "customer[password_confirmation]", with: ""
          click_button "新規登録"
          expect(current_path).to eq customer_registration_path
          expect(page).to have_content "パスワード確認とパスワードの入力が一致しません"
        end

        it "登録済の[ニックネーム]を使用" do
          visit new_customer_registration_path
          fill_in "customer[nick_name]", with: customer.nick_name
          fill_in "customer[email]", with: "email@test.com"
          fill_in "customer[password]", with: "password"
          fill_in "customer[password_confirmation]", with: "password"
          click_button "新規登録"
          expect(current_path).to eq customer_registration_path
          expect(page).to have_content "ニックネームはすでに存在します"
        end

        it "登録済の[メールアドレス]を使用" do
          visit new_customer_registration_path
          fill_in "customer[nick_name]", with: "nick_name"
          fill_in "customer[email]", with: customer.email
          fill_in "customer[password]", with: "password"
          fill_in "customer[password_confirmation]", with: "password"
          click_button "新規登録"
          expect(current_path).to eq customer_registration_path
          expect(page).to have_content "メールアドレスはすでに存在します"
        end
      end
    end

    describe "ユーザーログイン" do
      context "ログインに成功する" do
        it "ユーザーが存在する" do
          visit new_customer_session_path
          fill_in "customer[email]", with: customer.email
          fill_in "customer[password]", with: customer.password
          click_button "ログイン"
          expect(current_path).to eq public_customer_path(customer.id)
          expect(page).to have_content "ログインしました。"
        end
      end

      context "ログインに失敗する" do
        it "ログインフォームが空白" do
          visit new_customer_session_path
          fill_in "customer[email]", with: ""
          fill_in "customer[password]", with: ""
          click_button "ログイン"
          expect(current_path).to eq new_customer_session_path
          expect(page).to have_content "メールアドレスまたはパスワードが違います。"
        end

        it "パスワードが間違っている" do
          visit new_customer_session_path
          fill_in "customer[email]", with: customer.email
          fill_in "customer[password]", with: "test"
          click_button "ログイン"
          expect(current_path).to eq new_customer_session_path
          expect(page).to have_content "メールアドレスまたはパスワードが違います。"
        end

        it "メールアドレスが間違っている" do
          visit new_customer_session_path
          fill_in "customer[email]", with: "test@test.com"
          fill_in "customer[password]", with: customer.password
          click_button "ログイン"
          expect(current_path).to eq new_customer_session_path
          expect(page).to have_content "メールアドレスまたはパスワードが違います。"
        end
      end
    end

    describe "ページ遷移確認" do
      context "会員のマイページへアクセス" do
        it "会員のマイページへのアクセスに失敗する" do
          visit public_customer_path(customer.id)
          expect(page).to have_content "ログインもしくはアカウント登録してください。"
          expect(current_path).to eq new_customer_session_path
        end
      end

      context "会員情報編集画面へアクセス" do
        it "会員情報編集画面へのアクセスに失敗する" do
          visit edit_public_customer_path(customer.id)
          expect(page).to have_content "ログインもしくはアカウント登録してください。"
          expect(current_path).to eq new_customer_session_path
        end
      end
    end
  end

  describe "ログイン後" do
    before { login_as(customer) }
  end
end

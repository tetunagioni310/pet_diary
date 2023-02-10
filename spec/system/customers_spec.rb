# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Customers', type: :system do
 let!(:customer) { create(:customer) }
 describe 'ログイン前' do
   describe 'ユーザー新規登録' do
     context 'フォームの入力値が正常' do
       it 'ユーザーの新規作成が成功する' do
         visit new_customer_registration_path
         fill_in "customer[nick_name]", with: "nick_name"
         fill_in "customer[email]", with: "email@test.com"
         fill_in "customer[password]", with: "password"
         fill_in "customer[password_confirmation]", with: "password"
         click_button "新規登録"
         expect(current_path).to eq public_customer_path(2)
         # customer_id == 2 を何て書けばいいか
         expect(page).to have_content "アカウント登録が完了しました。"
       end
     end
     
     context 'ニックネームが未入力' do
       it 'ユーザーの新規作成が失敗する' do
        visit new_customer_registration_path
        fill_in "customer[nick_name]", with: ""
        fill_in "customer[email]", with: "email@test.com"
        fill_in "customer[password]", with: "password"
        fill_in "customer[password_confirmation]", with: "password"
        click_button "新規登録"
        expect(current_path).to eq customer_registration_path
        expect(page).to have_content "ニックネームを入力してください"
       end
     end
     
     context 'メールアドレスが未入力' do
       it 'ユーザーの新規作成が失敗する' do
        visit new_customer_registration_path
        fill_in "customer[nick_name]", with: "nick_name"
        fill_in "customer[email]", with: ""
        fill_in "customer[password]", with: "password"
        fill_in "customer[password_confirmation]", with: "password"
        click_button "新規登録"
        expect(current_path).to eq customer_registration_path
        expect(page).to have_content "メールアドレスを入力してください"
       end
     end
     
     context '登録済のメールアドレスを使用' do
       it 'ユーザーの新規作成が失敗する' do
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
     
     context '登録済のメールアドレスを使用' do
       it 'ユーザーの新規作成が失敗する' do
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
 end
end
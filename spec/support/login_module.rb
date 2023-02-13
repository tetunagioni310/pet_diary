# frozen_string_literal: true

module LoginModule
  def login_as(customer)
    visit new_customer_session_path
    fill_in "customer[email]", with: customer.email
    fill_in "customer[password]", with: "password"
    click_button "ログイン"
  end
end

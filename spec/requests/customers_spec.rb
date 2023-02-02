require 'rails_helper'
RSpec.describe 'Customers' do
  it 'ログインしてる時、ユーザーの詳細ページにアクセスできる' do
    customer = create(:customer)
    sign_in customer
    get public_customer_path(customer.id)
    expect(response).to have_http_status(200)
  end
end

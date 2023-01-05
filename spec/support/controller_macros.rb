module ControllerMacros
  # 公式の
  def login_admin(admin)
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    sign_in admin
  end

  def login_customer(customer)
    allow(controller).to receive(:authenticate_customer!).and_return(customer)
    # 下記の書き方は非推奨とされており、上記の書き方に変更
    # controller.stub(:authenticate_customer!).and_return true
    @request.env["devise.mapping"] = Devise.mappings[:customer]
    sign_in customer
  end

end
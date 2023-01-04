module ControllerMacros

  def login_admin(admin)
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    sign_in admin
  end

  def login_customer(customer)
    controller.stub(:authenticate_customer!).and_return true
    @request.env["devise.mapping"] = Devise.mappings[:customer]
    sign_in customer
  end

end
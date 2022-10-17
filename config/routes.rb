Rails.application.routes.draw do
  
  root to: "public/homes#top"
  
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
  
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers ,skip: [:password], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  
end

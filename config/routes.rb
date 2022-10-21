Rails.application.routes.draw do
  
  root to: "public/homes#top"
  
  namespace :public do
    get 'homes/top'
    get 'homes/about'
    resources :customers, only: [:show,:edit,:update]
  end
  
  namespace :admin do
    resources :groups, only: [:index,:create,:edit,:destroty]
  end
  
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers ,skip: [:password], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions',
  }
  
  devise_scope :customer do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  
end

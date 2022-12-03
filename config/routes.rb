Rails.application.routes.draw do

  root to: "public/homes#top"

  namespace :public do
    get 'homes/top'
    get 'homes/about'

    resources :posts do
      collection do
        get 'search'
      end

      resources :likes, only: [:create,:destroy]
      resources :comments, only: [:create,:destroy]
    end

    resources :schedules, only: [:index,:show,:create,:edit,:update,:destroy]

    resources :pets
    namespace :pets do
      resources :works, only: [:show]
    end


    resources :items, only: [:index,:show,:create,:update,:destroy]
    resources :use_items, only: [:index,:create,:update,:destroy] do
      collection do
        delete 'destroy_all'
      end
    end

    resources :works, only: [:index,:show,:new,:create,:destroy] do
      collection do
        get 'log'
      end
    end

    resources :favorite_items, only: [:index,:edit,:create,:update,:destroy]

    namespace :favorite_items do
      resources :use_items, only: [:create]
    end

    resources :customers, only: [:show,:edit,:update] do
      collection do
        get 'member_info'
        get 'member_info_edit'
        patch 'member_info_update'
        get 'quit'
        patch 'withdrawal'
      end

      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end

    namespace :customers do
      resources :pets, only: [:show]
    end

  end

  namespace :admin do
    resources :groups, only: [:index,:create,:edit,:update,:destroy]
    
    resources :customers, only: [:index,:show] do
      resources :posts, only: [:index,:show]
    end
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

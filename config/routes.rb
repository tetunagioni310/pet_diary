# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "public/homes#top"

  namespace :public do
    get "homes/top"
    get "homes/about"

    resources :posts do
      collection do
        get "search"
        # get 'post_all_prototype'
        get "post_all"
        get "search_all"
      end
      resources :likes, only: %i[create destroy]
      resources :comments, only: %i[create edit update destroy]
    end

    get "schedules/schedule_list"
    resources :schedules, only: %i[index show create edit update destroy]

    resources :pets do
      get "work_index"
      get "post_index"
    end

    resources :items, only: %i[index show create update destroy] do
      patch "minimum_capacity"
    end

    resources :use_items, only: %i[index create update destroy] do
      collection do
        delete "destroy_all"
      end
    end

    resources :works, only: %i[index show new create destroy] do
      collection do
        get "log"
        get "search"
      end
    end

    resources :favorite_items, only: %i[index edit create update destroy]

    namespace :favorite_items do
      resources :use_items, only: [:create]
    end

    resources :groups, only: %i[show]

    resources :customers, only: %i[show edit update] do
      collection do
        get "search_page"
        get "search"
        get "introduction_edit"
        patch "introduction_update"
        get "quit"
        patch "withdrawal"
      end

      resource :relationships, only: %i[create destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
      get "pet_index"
      get "post_index"
      get "post_search"
    end

    resources :notifications, only: [:index]
  end

  namespace :admin do
    get "homes/top"

    resources :groups, only: %i[index create edit update destroy]
    resources :customers, only: %i[index edit update] do
      resources :posts, only: %i[index show destroy]
    end
    namespace :customers do
      namespace :posts do
        resources :comments, only: %i[destroy]
      end
    end
  end

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, skip: [:password], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_scope :customer do
    post "public/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: %i[registrations password], controllers: {
    sessions: "admin/sessions"
  }
end

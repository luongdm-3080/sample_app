Rails.application.routes.draw do
  scope "(:locale)", locale: /en|ja|vi/ do
    root "static_pages#home"

    get "/help", to: "static_pages#help"
    get "/home", to: "static_pages#home"
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users do
      member do
        get "/following", to: "followings#index"
        get "/followers", to: "followers#index"
      end
    end
    resources :relationships,only: %i(create destroy)
    resources :account_activations, only: :edit
    resources :password_resets, only: %i(new create edit update)
    resources :microposts, only: %i(create destroy)
  end
end

Rails.application.routes.draw do
   root "users#index"
  resources :users, only: [:index,:show, :new, :create]
  resources :temperatures, only: [:index, :new, :create]
  resources :users do
    member do
      get 'next_user', to: 'users#next_user'  # 追加したルート
    end
  end
end

Rails.application.routes.draw do
  root 'users#index'  # トップページ

  # 設定ページへのルート
  get 'settings', to: 'users#settings'  # 設定ページ用

  resources :users do
    member do
      get 'next_user'  # ユーザーの次の情報を取得するためのルート
       get 'edit'
    end
  end


  

  resources :temperatures, only: [:index, :new, :create]
end



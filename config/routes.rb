Rails.application.routes.draw do
  root 'static_pages#top'

  # ログイン・ログアウト関係
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  # ユーザー登録用
  get 'signup', to: 'users#new'
  resources :users, only: [:create]

  # グループ・ペット管理関係
  resources :group_members, only: [:new, :create]
  
  # 💡 グループとペットの親子関係を1つに綺麗にまとめました
  resources :groups, only: [:new, :create, :show] do
    resources :pets do
      resources :care_items, only: [:create, :destroy]
      resources :care_records, only: [:create, :destroy]
    end
  end
end
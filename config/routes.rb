Rails.application.routes.draw do
  get 'group_members/new'
  get 'group_members/create'
  get 'groups/new'
  get 'groups/create'
  get 'groups/show'
  get 'user_sessions/new'
  get 'user_sessions/create'
  get 'user_sessions/destroy'
  root 'static_pages#top'
  resources :groups, only: [:new, :create, :show]

  # ユーザー登録用
  # /signup で UsersController の new アクション（登録画面）を呼び出す
  get 'signup', to: 'users#new'
  
  # resources を使うことで /users (POST) などの基本ルートを作成
  resources :users, only: %i[create]

  # ログイン関係（後で実装する際の器だけ作っておく）
  # 現時点ではエラーを避けるため、とりあえず root などに飛ばす設定でもOK
  get 'login', to: 'static_pages#top', as: :login 

  # ログイン画面
get 'login', to: 'user_sessions#new'
# ログイン実行
post 'login', to: 'user_sessions#create'
# ログアウト
delete 'logout', to: 'user_sessions#destroy'
end
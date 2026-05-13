Rails.application.routes.draw do
  root 'static_pages#top'

  # ユーザー登録用
  # /signup で UsersController の new アクション（登録画面）を呼び出す
  get 'signup', to: 'users#new'
  
  # resources を使うことで /users (POST) などの基本ルートを作成
  resources :users, only: %i[create]

  # ログイン関係（後で実装する際の器だけ作っておく）
  # 現時点ではエラーを避けるため、とりあえず root などに飛ばす設定でもOK
  get 'login', to: 'static_pages#top', as: :login 
end
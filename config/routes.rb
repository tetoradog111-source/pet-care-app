Rails.application.routes.draw do
  root 'static_pages#top'

  # ログイン関係（後でSessionsControllerなどを作る想定）
  get 'login', to: 'static_pages#top' # 一旦トップを表示するようにしておく
  post 'login', to: 'static_pages#top'

  # 新規登録関係（後でUsersControllerなどを作る想定）
  get 'signup', to: 'static_pages#top'
end
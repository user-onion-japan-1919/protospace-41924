Rails.application.routes.draw do
  root to: "prototypes#index"

  devise_for :users
  resources :users, only: [:show] do  # ユーザー情報を表示するshowアクション
    resources :comments, only: [:create]  # ユーザーに紐づくコメント投稿用のルート
  end

  # プロトタイプに関するルート（詳細表示、作成、編集、削除）
  resources :prototypes, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    # コメント関連のルート
    resources :comments, only: [:create]
  end
end
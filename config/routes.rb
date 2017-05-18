Rails.application.routes.draw do
  devise_for :users
  root 'messages#index'
  resources :messages, only: [:show]
  get 'groups/search' => 'groups#search'
  # POSTにGETで直打ち、または不正な投稿の後にリロードされた場合のリダイレクト
  get 'groups' => redirect('/groups/new')
  resources :groups, only: [:new, :create, :edit, :update] do
    resources :messages, only: [:create] do
    end
  end
end

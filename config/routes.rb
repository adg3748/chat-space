Rails.application.routes.draw do
  devise_for :users
  root 'messages#index'
  resources :messages, only: [:show]
  resources :groups, only: [:new, :create, :edit, :update] do
    resources :messages, only: [:create] do
    end
  end
end

Rails.application.routes.draw do
  resources :tasksuites
  resources :suites
  resources :tasks
  resources :users, only: [:index, :show, :edit, :update, :destroy], path: :profiles
  devise_for :users, controllers: { omniauth_callbacks: 'users/oauth' }
  root 'tasks#index'
end

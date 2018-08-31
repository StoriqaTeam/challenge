Rails.application.routes.draw do
  resources :suites do
    resources :tasks, only: [:index, :new, :create, :destroy], controller: "suites/tasks"
  end
  resources :tasks
  resources :users, only: [:index, :show, :edit, :update, :destroy], path: :profiles
  devise_for :users, controllers: { omniauth_callbacks: 'users/oauth' }
  root 'tasks#index'
end

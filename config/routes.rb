Rails.application.routes.draw do
  resources :suites do
    resources :tasks, only: [:index, :new, :create, :destroy], controller: "suites/tasks"
  end
  resources :tasks
  resources :users, only: [:index, :show, :edit, :update, :destroy], path: :profiles do
    resources :suite_solutions, only: [:index, :new, :create, :destroy], controller: "profiles/suite_solutions"
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/oauth' }
  get '/start', to: 'suite_solutions#start', as: :suite_solutions_start
  root 'users#index'
end

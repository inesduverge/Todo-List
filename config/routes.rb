Rails.application.routes.draw do
  root :to => "users#new"
  get "log_in" => 'sessions#new', :as => "log_in"
  get "log_out" => 'sessions#destroy', :as => "log_out"
  get "sign_up" => 'users#new', :as => "sign_up"
  resources :users
  resources :sessions
  resources :shares, only: [:create]
  resources :checklists, only: [:create, :show, :destroy]
  resources :notes, only: [:create, :destroy]
  resources :checklist_items, only: [:create, :update, :destroy]
  resources :pointlists, only: [:create, :show, :destroy]
  resources :pointlist_items, only: [:create]

  resources :tabs, only: [:index, :create, :show, :update, :destroy]
end

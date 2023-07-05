Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :events
    resources :spots
    root to: "events#index"
  end

  root to: "static_pages#home"
  get  "/help",    to: "static_pages#help"
  get  "/about",   to: "static_pages#about"

  resources :events, only: [:index, :show]
  resources :spots, only: [:index, :show]

  get   'contact'         => 'contact#index'
  get 'contact/confirm'
  get 'contact/thanks'
  post  'contact/confirm' => 'contact#confirm'
  post  'contact/thanks'  => 'contact#thanks'

  get  "/routes",   to: "route_search#index"
end

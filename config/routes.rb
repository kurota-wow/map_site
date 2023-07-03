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
  get  "/contact",   to: "static_pages#contact"
  resources :events
  resources :spots
end

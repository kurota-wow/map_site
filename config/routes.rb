Rails.application.routes.draw do
  namespace :admin do
      resources :events

      root to: "events#index"
    end
  root "static_pages#home"
  get  "/help",    to: "static_pages#help"
  get  "/about",   to: "static_pages#about"
  get  "/contact",   to: "static_pages#contact"
  resources :events
end

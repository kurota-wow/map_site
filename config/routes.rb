Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :events do
      delete :image, on: :member, action: :destroy_image
    end
    resources :spots do
      delete :icon, on: :member, action: :destroy_icon
    end
    root to: "events#index"
  end

  root to: "static_pages#home"
  get  "/help",    to: "static_pages#help"
  get  "/about",   to: "static_pages#about"

  resources :events, only: [:index, :show]
  resources :spots, only: [:index, :show]

  resources :contact, only: [:new, :create]
  post 'contact/confirm', to: 'contact#confirm', as: 'confirm'
  get 'thanks', to: 'contact#thanks', as: 'thanks'

  get  "/routes",   to: "route_search#index"
end

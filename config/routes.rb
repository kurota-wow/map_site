Rails.application.routes.draw do
  get 'customers/show'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    passwords: 'customers/passwords',
    registrations: 'customers/registrations'
  }
  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'customers/sessions#guest_sign_in'
  end

  resources :customers, only: [:show]

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
  resources :spots, only: [:index, :show] do
    resources :spot_comments, only: %i[create destroy]
    resource :bookmarks, only: [:create, :destroy]
  end

  resources :contact, only: [:new, :create]
  post 'contact/confirm', to: 'contact#confirm', as: 'confirm'
  get 'thanks', to: 'contact#thanks', as: 'thanks'

  get  "/routes",   to: "route_search#index"
end

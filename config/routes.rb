Rails.application.routes.draw do
  root to: "homes#top"
  get 'home/about', to: 'homes#about', as: :about
  resources :users, only: [:new, :create, :index, :show, :edit, :update], path_names: { new: 'sign_up' }
  resources :books, only: [:index, :show, :create, :show, :edit, :update, :destroy]

  resource :session, only: [:new, :create, :destroy]
  resources :passwords, param: :token

end

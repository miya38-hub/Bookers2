Rails.application.routes.draw do
  resources :users, only: [:new, :create] , path_names: { new: 'sign_up' }
  resources :books, only: [:new, :index, :show]

  resource :session
  resources :passwords, param: :token
  root to: "homes#top"
end

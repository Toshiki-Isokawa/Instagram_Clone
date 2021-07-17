Rails.application.routes.draw do
  get 'users/show'
  devise_for :users, 
    controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :users, :only => [:show, :index]
  resources :posts do 
    resources :comments
  end
end

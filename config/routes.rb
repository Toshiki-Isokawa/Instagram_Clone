Rails.application.routes.draw do
  get 'about/index'
  get 'ranking/index'
  devise_for :users, 
    controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :users, :only => [:show, :index] do 
    member do
      get :likes
    end
  end
  
  resources :posts do 
    resources :comments
  end
  resources :favorites, :only => [:create, :destroy]
  resources :ranking, :only => [:index]
  resources :about, :only => [:index]
end

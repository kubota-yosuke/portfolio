Rails.application.routes.draw do
  resources :matters do
    collection do
      get :likes
    end
  end

  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  delete 'logout' => 'user_sessions#destroy', :as => :logout
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => 'users#index'
  resources :users
  resources :likes, only: %i[create destroy]

  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]
  
end

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  get 'password_resets/new'
  get 'password_resets/create'
  get 'password_resets/edit'
  get 'password_resets/update'
  resources :matters do
    resources :comments, only: [:create]
    resources :applies, only: %i[index create destroy]
    resources :contracts, only: %i[index create destroy]
    collection do
      get :likes
    end
  end

  resources :password_resets, only: %i[new create edit update]

  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  delete 'logout' => 'user_sessions#destroy', :as => :logout
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => 'top#index'
  resources :users
  resources :likes, only: %i[create destroy]

  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]

  put 'users/follow/:user_id',to: 'users#follow'
  put 'users/unfollow/:user_id',to: 'users#unfollow'
  get 'users/follow_list/:user_id',to: 'users#follow_list'
  get 'users/follower_list/:user_id',to:'users#follower_list'
  
end

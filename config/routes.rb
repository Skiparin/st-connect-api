Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', :controllers => { registrations: 'registrations' }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:show] do
  	resources :user_searches, only: [:index, :create]
  	resources :educations, only: [:create, :update]
  	resources :experiences, only: [:create, :update]
  	resources :skills, only: [:create, :update]
  end

  resources :posts, only: [:index, :show, :create, :update] do
      resources :comments, only: [:create, :update]
      resources :likes, only: [:create, :update]
  end

end

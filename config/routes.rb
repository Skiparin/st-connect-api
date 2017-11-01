Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', :controllers => { registrations: 'registrations' }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

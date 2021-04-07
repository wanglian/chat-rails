Rails.application.routes.draw do
  apipie
  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :channels, only: [:index] do
        member do
          post :join
        end
        resources :messages, only: [:index, :create]
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

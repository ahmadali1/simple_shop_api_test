Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # post :sign_up, to: 'registrations#create'
      post :login, to: 'sessions#create'
      # get  :validate_token, to: 'sessions#show'
      resources :orders
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

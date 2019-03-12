Rails.application.routes.draw do
  resources :users
  post "signup", to: "users#create"
  post "login", to: "sessions#login"

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :categories do
        resources :lessons
      end
    end
  end
end

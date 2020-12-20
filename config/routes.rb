Rails.application.routes.draw do
  get 'welcome/index'
  root 'home#index'

  namespace :api do
    namespace :v1 do
      resources :questions, only: [:index]
    end
  end
end

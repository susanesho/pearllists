Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
    end
  end
  namespace :api do
    namespace :v1 do
      post 'auth/login', to: 'sessions#create'
      get 'auth/logout', to: 'sessions#destroy'
    end
  end
  namespace :api do
    namespace :v1 do
      resources :bucketlists
    end
  end
end

Rails.application.routes.draw do
  mount Sidekiq::Web => '/admin/sidekiq' 

  root 'home#index'
  get 'search' => 'search#index'

  namespace :api, format: :json do
    resources :podcasts, only: [:submit] do 
      collection { post :submit }
    end
  end
end

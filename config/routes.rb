Rails.application.routes.draw do
  root 'home#index'
  get 'search' => 'search#index'
end

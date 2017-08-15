Rails.application.routes.draw do
  resources :influencers

  root 'influencers#index'
end

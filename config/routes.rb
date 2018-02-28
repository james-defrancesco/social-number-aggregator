Rails.application.routes.draw do

  post 'update', to: 'influencers#update_users_social'
  resources :influencers do
    collection do
      get :search, action: 'search_influencer', as: 'search_influencer'
      get 'search/:q', action: 'search', as: 'search'

    end

  end

  root 'influencers#index'

  
end

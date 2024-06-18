# config/routes.rb
Rails.application.routes.draw do
  resources :vcenters do
    member do
      post :update_datacenters
    end
    resources :datacenters do
      resources :compute_clusters do
        resources :datastores, only: [:show]
        resources :networks, only: [:show]
      end
    end
  end
  resources :subnets
  root "home#index"
end

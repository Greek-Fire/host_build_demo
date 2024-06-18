# config/routes.rb
Rails.application.routes.draw do
  resources :vcenters do
    resources :vcenter_credentials, only: [:new, :create, :edit, :update, :destroy] do
      post 'verify', on: :member
    end
    member do
      post 'update_datacenters'
    end
    resources :datacenters, only: [:show] do
      resources :compute_clusters, only: [:show] do
        get 'networks', on: :member
      end
    end
  end

  root to: 'home#index'
end

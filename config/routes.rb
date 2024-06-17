# config/routes.rb

Rails.application.routes.draw do
  root 'home#index'

  resources :vcenters do
    resources :datacenters, only: [:show] do
      resources :compute_clusters, only: [:show] do
        get 'datastores', on: :member
        get 'networks', on: :member
      end
    end
    resources :vcenter_credentials, only: [:new, :create, :edit, :update, :destroy, :index, :show] do
      member do
        post 'verify'
      end
    end
  end

  resources :subnets
end

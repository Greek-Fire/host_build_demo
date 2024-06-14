Rails.application.routes.draw do
  root 'home#index'

  resources :vcenters do
    member do
      post 'update_datacenters'
    end
    resources :datacenters, only: [:show] do
      resources :compute_clusters, only: [:show] do
        member do
          get 'datastores'
          get 'networks'
        end
      end
    end
    resources :vcenter_credentials, only: [:new, :create, :edit, :update, :destroy, :index, :show] do
      member do
        post 'verify'
      end
    end
  end
end


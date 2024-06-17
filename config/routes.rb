Rails.application.routes.draw do
  root 'home#index'

  resources :vcenters do
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
    post 'update_datacenters', on: :member
  end
end

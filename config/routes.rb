Rails.application.routes.draw do
  root 'home#index'

  resources :vcenters do
    resources :datacenters, only: [:show]
    resources :vcenter_credentials, only: [:new, :create, :edit, :update, :destroy, :index, :show] do
      member do
        post 'verify'
      end
    end
    member do
      post 'update_datacenters'
    end
  end

  resources :subnets, only: [:new, :create, :index]
end

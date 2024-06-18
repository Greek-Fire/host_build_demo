Rails.application.routes.draw do
  root 'vcenters#index'
  resources :vcenters do
    collection do
      post :fetch_vcenters
    end
  end
  resources :datacenters
  resources :compute_clusters
  resources :datastore_clusters
  resources :datastores
  resources :vm_networks
  resources :virtual_machines
  resources :esx_hosts
  resources :credentials
  # Define any nested routes if necessary
end


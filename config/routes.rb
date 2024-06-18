Rails.application.routes.draw do
  resources :vcenters
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


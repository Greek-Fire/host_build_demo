# app/controllers/networks_controller.rb
class NetworksController < ApplicationController
    before_action :set_vcenter
    before_action :set_datacenter
    before_action :set_compute_cluster
  
    def index
      @networks = @compute_cluster.vm_networks
    end
  
    private
  
    def set_vcenter
      @vcenter = Vcenter.find(params[:vcenter_id])
    end
  
    def set_datacenter
      @datacenter = @vcenter.datacenters.find(params[:datacenter_id])
    end
  
    def set_compute_cluster
      @compute_cluster = @datacenter.compute_clusters.find(params[:compute_cluster_id])
    end
  end
  
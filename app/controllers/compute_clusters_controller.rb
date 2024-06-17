class ComputeClustersController < ApplicationController
  before_action :set_vcenter
  before_action :set_datacenter
  before_action :set_compute_cluster, only: [:show, :datastores, :networks]

  def show
  end

  def datastores
    @datastores = @compute_cluster.datastores
  end

  def networks
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
    @compute_cluster = @datacenter.compute_clusters.find_by(name: params[:id])
  end
end

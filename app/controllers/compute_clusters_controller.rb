# app/controllers/compute_clusters_controller.rb
class ComputeClustersController < ApplicationController
  before_action :set_vcenter
  before_action :set_datacenter
  before_action :set_compute_cluster, only: [:show]

  def show
    @total_storage = @compute_cluster.datastores.sum(:capacity)
  end

  private

  def set_vcenter
    @vcenter = Vcenter.find(params[:vcenter_id])
  end

  def set_datacenter
    @datacenter = @vcenter.datacenters.find(params[:datacenter_id])
  end

  def set_compute_cluster
    @compute_cluster = @datacenter.compute_clusters.find(params[:id])
  end
end

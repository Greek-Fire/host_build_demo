class VcentersController < ApplicationController
  before_action :set_vcenter, only: [:show, :edit, :destroy, :update_datacenters]

  def index
    @vcenters = Vcenter.all
  end

  def show
    @vcenter_credentials = @vcenter.vcenter_credentials
    @datacenters = @vcenter.datacenters.includes(compute_clusters: [:datastores, :vm_networks])
  end

  def new
    @vcenter = Vcenter.new
  end

  def create
    @vcenter = Vcenter.new(vcenter_params)
    if @vcenter.save
      redirect_to @vcenter, notice: 'vCenter was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def destroy
    @vcenter.destroy
    redirect_to vcenters_url, notice: 'vCenter was successfully destroyed.'
  end

  def update_datacenters
    fetch_and_store_datacenters(@vcenter)
    redirect_to vcenter_path(@vcenter)
  end

  private

  def set_vcenter
    @vcenter = Vcenter.find(params[:id])
  end

  def vcenter_params
    params.require(:vcenter).permit(:name, :url)
  end

  def fetch_and_store_datacenters(vcenter)
    require 'fog/vsphere'

    credential = vcenter.vcenter_credentials.first
    return unless credential

    connection = Fog::Compute.new(
      provider: 'Vsphere',
      vsphere_username: credential.username,
      vsphere_password: credential.password,
      vsphere_server: vcenter.url,
      vsphere_ssl: credential.ssl_verification,
      vsphere_expected_pubkey_hash: 'a7401d408f9a4ac60848fe34242a9a9c89fcfb73231b2053f64540e8fb03721e',
      vsphere_insecure: !credential.ssl_verification
    )

    connection.datacenters.all.each do |datacenter|
      dc = vcenter.datacenters.find_or_create_by(name: datacenter.name)
      datacenter.clusters.each do |cluster|
        cc = dc.compute_clusters.find_or_create_by(name: cluster.name)
        cluster.networks.each do |network|
          cc.vm_networks.find_or_create_by(name: network.name)
        end
        cluster.datastores.each do |datastore|
          cc.datastores.find_or_create_by(name: datastore.name)
        end
      end
    end
  rescue => e
    Rails.logger.error("Failed to fetch datacenters: #{e.message}")
  end

  def calculate_total_storage(cluster)
    cluster.datastores.sum(:capacity) # Ensure you have a capacity column in datastores
  end
end

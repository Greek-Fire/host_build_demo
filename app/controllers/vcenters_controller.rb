class VcentersController < ApplicationController
  before_action :set_vcenter, only: [:show, :edit, :destroy, :update_datacenters]

  def index
    @vcenters = Vcenter.all
  end

  def show
    @vcenter_credentials = @vcenter.vcenter_credentials
    @datacenters = @vcenter.datacenters
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

  def update
    if @vcenter.update(vcenter_params)
      redirect_to @vcenter, notice: 'Vcenter was successfully updated.'
    else
      render :edit
    end
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
    @vcenter = Vcenter.find_by(id: params[:id])
    unless @vcenter
      logger.error "Vcenter with id #{params[:id]} not found"
      redirect_to vcenters_path, alert: 'Vcenter not found'
    end
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
      end
    end
  rescue => e
    Rails.logger.error("Failed to fetch datacenters: #{e.message}")
  end
end

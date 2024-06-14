class VcentersController < ApplicationController
  before_action :set_vcenter, only: [:show, :edit, :update, :destroy, :update_datacenters]
  #before_action :fetch_datacenters, only: [:show]

  def index
    @vcenters = Vcenter.all
  end

  def show
    @vcenter_credentials = @vcenter.vcenter_credentials
    @datacenters = fetch_datacenters(@vcenter)
  end

  def new
    @vcenter = Vcenter.new
  end

  def create
    @vcenter = Vcenter.new(vcenter_params)
    if @vcenter.save
      redirect_to vcenters_path, notice: 'vCenter was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @vcenter.update(vcenter_params)
      redirect_to vcenters_path, notice: 'vCenter was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @vcenter.destroy
    redirect_to vcenters_path, notice: 'vCenter was successfully deleted.'
  end


  def update_datacenters
    @datacenters = fetch_datacenters(@vcenter)
    if @datacenters.present?
      flash[:notice] = "Datacenters updated successfully."
    else
      flash[:alert] = "Failed to update datacenters."
    end
    redirect_to vcenter_path(@vcenter)
  end

  private

  def set_vcenter
    @vcenter = Vcenter.find(params[:id])
  end

  def vcenter_params
    params.require(:vcenter).permit(:name, :url)
  end

  def fetch_datacenters(vcenter)
    require 'fog/vsphere'

    credential = vcenter.vcenter_credentials.first
    if credential.nil?
      Rails.logger.debug("No credentials found for vCenter #{vcenter.id}")
      return []
    end

    connection = Fog::Compute.new(
      provider: 'Vsphere',
      vsphere_username: credential.username,
      vsphere_password: credential.password,
      vsphere_server: vcenter.url,
      vsphere_ssl: credential.ssl_verification,
      vsphere_expected_pubkey_hash: 'a7401d408f9a4ac60848fe34242a9a9c89fcfb73231b2053f64540e8fb03721e', 
      vsphere_insecure: !credential.ssl_verification
    )

    connection.datacenters.all
  rescue => e
    Rails.logger.error("Failed to fetch datacenters: #{e.message}")
    []
  end
end


class VcenterCredentialsController < ApplicationController 
  before_action :set_vcenter, only: [:index, :new, :edit, :create, :update, :destroy, :verify]
  before_action :set_vcenter_credential, only: [:edit, :update, :destroy, :verify]

  def new
    @vcenter_credential = VcenterCredential.new(vcenter_id: @vcenter.id)
  end

  def create
    @vcenter_credential = VcenterCredential.new(vcenter_credential_params)
    if @vcenter_credential.save
      redirect_to vcenter_path(@vcenter_credential.vcenter), notice: 'vCenter credentials were successfully created.'
    else
      render :new
    end
  end

  def edit
    @vcenter_credential = VcenterCredential.find(params[:id])
  end

  def update
    @vcenter_credential = VcenterCredential.find(params[:id])
    if @vcenter_credential.update(vcenter_credential_params)
      redirect_to vcenter_path(@vcenter_credential.vcenter), notice: 'vCenter credentials were successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @vcenter_credential = VcenterCredential.find(params[:id])
    @vcenter_credential.destroy
    redirect_to vcenter_path(@vcenter_credential.vcenter), notice: 'vCenter credential was successfully deleted.'
  end

  def verify
    @vcenter_credential = VcenterCredential.find(params[:id])
    @vcenter = @vcenter_credential.vcenter # Make sure @vcenter is set
    
    verification_success = verify_vcenter_credentials(@vcenter_credential)

    if verification_success
      flash[:notice] = "Credentials are valid."
    else
      flash[:alert] = "Credentials are invalid."
    end
    redirect_to vcenter_path(@vcenter_credential.vcenter)
  end

  private

  def set_vcenter
    @vcenter = Vcenter.find(params[:vcenter_id])
  end

  def set_vcenter_credential
    @vcenter_credential = VcenterCredential.find(params[:id])
  end

  def vcenter_credential_params
    params.require(:vcenter_credential).permit(:vcenter_id, :username, :password, :ssl_verification)
  end

  def verify_vcenter_credentials(credential)
    require 'fog/vsphere' 
  
    host = credential.vcenter.url
    user = credential.username
    pass = credential.password
    inse = credential.ssl_verification
  
    begin
      Rails.logger.debug "Attempting to connect to vCenter at #{host}" 
      Rails.logger.debug "username #{user}"
      Rails.logger.debug "SSL Verification: #{inse}"
      Rails.logger.debug "Insecure: #{!inse}"
      Rails.logger.debug "Password present: #{pass}" 
      
      connection = Fog::Compute.new(
      provider: 'Vsphere',
      vsphere_username: user,
      vsphere_password: pass,
      vsphere_server: host,
      vsphere_ssl: inse,
      vsphere_expected_pubkey_hash: 'a7401d408f9a4ac60848fe34242a9a9c89fcfb73231b2053f64540e8fb03721e', 
      vsphere_insecure: !inse
      )
      connection.servers.all
      Rails.logger.debug "Successfully connected to vCenter at #{host}"
      true
    rescue Excon::Errors::Unauthorized => e
      Rails.logger.error("vCenter credential verification failed: #{e.message}")
      false
    rescue OpenSSL::SSL::SSLError => e
      Rails.logger.error("SSL error during vCenter credential verification: #{e.message}")
      false
    rescue SocketError => e
      Rails.logger.error("Socket error during vCenter credential verification: #{e.message}")
      false
    rescue EOFError => e
      Rails.logger.error("EOF error during vCenter credential verification: #{e.message}")
      false
    rescue StandardError => e
      Rails.logger.error("Unexpected error during vCenter credential verification: #{e.message}")
      false
    end
  end
end

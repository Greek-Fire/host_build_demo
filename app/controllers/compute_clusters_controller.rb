class ComputeClustersController < ApplicationController
  before_action :set_vcenter
  before_action :set_datacenter
  before_action :set_compute_cluster, only: [:datastores, :networks]

  def datastores
    @datastores = fetch_datastores(@vcenter, @datacenter, @compute_cluster)
  end

  def networks
    @networks = fetch_networks(@vcenter, @datacenter, @compute_cluster)
  end

  private

  def set_vcenter
    @vcenter = Vcenter.find(params[:vcenter_id])
  end

  def set_datacenter
    @datacenter = params[:datacenter_id]
  end

  def set_compute_cluster
    @compute_cluster = params[:id]
  end

  def fetch_datastores(vcenter, datacenter_name, cluster_name)
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

    datacenter = connection.datacenters.get(datacenter_name)
    cluster = datacenter.clusters.get(cluster_name)

    cluster.datastores.map do |datastore|
      {
        name: datastore.name,
        type: datastore.type,
        total_storage: datastore.capacity,
        availability: datastore.accessible ? 'Accessible' : 'Inaccessible'
      }
    end
  rescue => e
    Rails.logger.error("Failed to fetch datastores: #{e.message}")
    []
  end

  def fetch_networks(vcenter, datacenter_name, cluster_name)
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

    datacenter = connection.datacenters.get(datacenter_name)
    cluster = datacenter.clusters.get(cluster_name)

    cluster.networks.map do |network|
      {
        name: network.name,
        type: network.class.name.demodulize,
        datacenter: datacenter_name,
        cluster: cluster_name
      }
    end
  rescue => e
    Rails.logger.error("Failed to fetch networks: #{e.message}")
    []
  end
end


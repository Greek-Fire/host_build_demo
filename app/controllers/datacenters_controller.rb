class DatacentersController < ApplicationController
  before_action :set_vcenter

  def show
    @datacenter = params[:id]
    @compute_clusters = fetch_compute_clusters(@vcenter, @datacenter)
  end

  private

  def set_vcenter
    @vcenter = Vcenter.find(params[:vcenter_id])
  end

  def fetch_compute_clusters(vcenter, datacenter_name)
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
    datacenter.clusters.map do |cluster|
      {
        name: cluster.name,
        num_hosts: cluster.num_host,
        total_storage: calculate_total_storage(cluster),
        total_vm_networks: calculate_total_vm_networks(cluster),
        availability: cluster.overall_status
      }
    end
  rescue => e
    Rails.logger.error("Failed to fetch compute clusters: #{e.message}")
    []
  end

  def calculate_total_storage(cluster)
    cluster.datastores.map(&:capacity).sum
  end

  def calculate_total_vm_networks(cluster)
    cluster.networks.size
  end
end


# VMwareClient.rb

require 'rbvmomi'

class VMwareClient
  attr_reader :vim

  def initialize(options = {})
    @host = options[:host]
    @user = options[:user]
    @password = options[:password]
    connect
  end

  def connect
    @vim ||= RbVmomi::VIM.connect(
      host: @host,
      user: @user,
      password: @password,
      insecure: true
    )
  end

  def disconnect
    @vim.close if @vim
    @vim = nil
  end

  def collect_datacenters
    ensure_connection
    root_folder = @vim.serviceInstance.content.rootFolder
    get_datacenters(root_ranker)
  end

  private

  def ensure_connection
    connect unless @vim
  end

  def get_datacenters(folder)
    datacenters = []
    folder.childEntity.grep(RbVmomi::VIM::Datacenter).each do |dc|
      datacenters << {
        name: dc.name,
        datastore_clusters: get_datastore_clusters(dc.datastoreFolder),
        compute_clusters: get_compute_clusters(dc.hostFolder),
        datastores: get_datastores(dc.datastoreFolder),
      }
    end
    datacenters
  end

  def get_datastore_clusters(folder)
    ds_clusters = []
    folder.childEntity.grep(RbVmomi::VIM::StoragePod).each do |ds_cluster|
      ds_clusters << {
        name: ds_cluster.name,
        total_storage: calculate_total_storage(ds_cluster),
        datastores: ds_cluster.childEntity.map(&:name),
      }
    end
    ds_clusters
  end

  def get_compute_clusters(folder)
    compute_clusters = []
    folder.childEntity.grep(RbVmomi::VIM::ClusterComputeResource).each do |cluster|
      compute_clusters << {
        name: cluster.name,
        vm_networks: get_vm_networks(cluster.network),
        vms: get_vms(cluster.resourcePool),
        hosts: get_hosts(cluster),
      }
    end
    compute_clusters
  end

  def get_vm_networks(networks)
    networks.map do |network|
      {
        name: network.name,
        vms: network.vm.map(&:name)
      }
    end
  end

  def get_vms(resourcePool)
    resourcePool.vm.map do |vm|
      vm.name
    end
  end

  def get_hosts(cluster)
    cluster.host.map do |host|
      {
        name: host.name,
        ip_address: host.config.network.vnic.map(&:spec).map(&:ip).compact.map(&:ipAddress).first,
        vm_networks: host.network.map(&:name)
      }
    end
  end

  def get_datastores(folder)
    folder.childEntity.grep(RbVmomi::VIM::Datastore).map do |store|
      {
        name: store.name,
        free_space: store.info.freeSpace,
        capacity: store.summary.capacity
      }
    end
  end

  def calculate_total_storage(ds_cluster)
    ds_cluster.childEntity.grep(RbVmomi::VIM::Datastore).sum { |ds| ds.summary.capacity }
  end
end

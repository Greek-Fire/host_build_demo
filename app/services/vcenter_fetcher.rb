# app/services/vcenter_fetcher.rb

require 'rbvmomi'

class VcenterFetcher
  def initialize(vcenter)
    @vcenter = vcenter
  end

  def fetch_and_store
    vim = connect_to_vcenter
    datacenters = fetch_datacenters(vim)
    store_datacenters(datacenters)
    vim.close
  end

  private

  def connect_to_vcenter
    RbVmomi::VIM.connect(host: @vcenter.fqdn, user: 'your-username', password: 'your-password', insecure: true)
  end

  def fetch_datacenters(vim)
    dc_list = vim.serviceInstance.content.rootFolder.childEntity.grep(RbVmomi::VIM::Datacenter)
    dc_list.map do |dc|
      {
        name: dc.name,
        compute_clusters: fetch_compute_clusters(dc),
        datastore_clusters: fetch_datastore_clusters(dc),
        datastores: fetch_datastores(dc.datastoreFolder)
      }
    end
  end

  def fetch_compute_clusters(datacenter)
    datacenter.hostFolder.childEntity.grep(RbVmomi::VIM::ClusterComputeResource).map do |cluster|
      {
        name: cluster.name,
        total_memory: cluster.summary.totalMemory,
        total_cores: cluster.summary.numCpuCores,
        total_storage: cluster.datastore.sum(&:summary.capacity)
      }
    end
  end

  def fetch_datastore_clusters(datacenter)
    datacenter.datastoreFolder.childEntity.grep(RbVmomi::VIM::StoragePod).map do |ds_cluster|
      {
        name: ds_cluster.name,
        total_storage: ds_cluster.summary.capacity
      }
    end
  end

  def fetch_datastores(datastore_folder)
    datastore_folder.childEntity.grep(RbVmomi::VIM::Datastore).map do |store|
      {
        name: store.name,
        storage_capacity: store.summary.capacity
      }
    end
  end

  def store_datacenters(datacenters)
    datacenters.each do |dc|
      dc_record = @vcenter.datacenters.find_or_create_by(name: dc[:name])
      store_compute_clusters(dc_record, dc[:compute_clusters])
      store_datastore_clusters(dc_record, dc[:datastore_clusters])
      store_datastores(dc_record, dc[:datastores])
    end
  end

  def store_compute_clusters(datacenter, clusters)
    clusters.each do |cluster|
      datacenter.compute_clusters.find_or_create_by(name: cluster[:name]) do |cc|
        cc.total_memory = cluster[:total_memory]
        cc.total_cores = cluster[:total_cores]
        cc.total_storage = cluster[:total_storage]
      end
    end
  end

  def store_datastore_clusters(datacenter, clusters)
    clusters.each do |cluster|
      datacenter.datastore_clusters.find_or_create_by(name: cluster[:name]) do |dc|
        dc.total_storage = cluster[:total_storage]
      end
    end
  end

  def store_datastores(datacenter, datastores)
    datastores.each do |store|
      datacenter.datastores.find_or_create_by(name: store[:name]) do |ds|
        ds.storage_capacity = store[:storage_capacity]
      end
    end
  end
end


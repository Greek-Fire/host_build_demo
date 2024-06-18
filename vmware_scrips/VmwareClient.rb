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
      insecure: true # Set to false if using SSL certificates
    )
  end

  def disconnect
    @vim.close if @vim
    @vim = nil
  end

  def collect_datacenters
    ensure_connection
    root_folder = @vim.serviceInstance.content.rootFolder
    get_datacenters(root_folder)
  end

  private

  def ensure_connection
    connect unless @vim
  end

  # Helper method to recursively collect all datacenter objects and additional details
  def get_datacenters(folder)
    datacenters = []
    folder.childEntity.each do |entity|
      if entity.is_a?(RbVmomi::VIM::Datacenter)
        clusters = entity.hostFolder.childEntity.grep(RbVmomi::VIM::ClusterComputeResource)
        num_clusters = clusters.count
        num_hosts = clusters.map(&:host).flatten.count
        num_vms = clusters.map { |cluster| cluster.resourcePool.vm }.flatten.count

        datacenters << {
          name: entity.name,
          clusters: num_clusters,
          hosts: num_hosts,
          vms: num_vms
        }
      elsif entity.is_a?(RbVmomi::VIM::Folder)
        datacenters.concat(get_datacenters(entity))  # Recursive call to navigate through folders
      end
    end
    datacenters
  end
end

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
    @vim = nil  # Reset @vim to nil after closing
  end

  def collect_datacenters
    connect unless @vim  # Ensure connection is established
    dc_mob = @vim.serviceInstance.find_datacenter
    dc_mob.map { |dc| dc.name }
  end

  # Add more methods for other VMware vSphere operations as needed
end

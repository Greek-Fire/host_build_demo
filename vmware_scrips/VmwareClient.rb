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
    if @vim.nil?
      @vim = RbVmomi::VIM.connect(
        host: @host,
        user: @user,
        password: @password,
        insecure: true # Set to false if using SSL certificates
      )
    end
  end

  def disconnect
    @vim.close if @vim
    @vim = nil
  end

  def collect_datacenters
    ensure_connection
    dc_mob = @vim.serviceInstance.find_datacenter
    dc_mob.map { |dc| dc.name }
  end

  private

  def ensure_connection
    connect unless @vim
  end
end

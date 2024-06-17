class SubnetsController < ApplicationController
    before_action :set_vm_networks, only: [:new, :create]
  
    def new
      @subnet = Subnet.new
    end
  
    def create
      @subnet = Subnet.new(subnet_params)
      if @subnet.save
        redirect_to subnets_path, notice: 'Subnet was successfully created.'
      else
        render :new
      end
    end
  
    def index
      @subnets = Subnet.all
    end
  
    private
  
    def subnet_params
      params.require(:subnet).permit(:name, :address, :cidr, :mask, :gateway, :dns1, :dns2, :vm_network)
    end
  
    def set_vm_networks
      @vm_networks = fetch_vm_networks
    end
  
    def fetch_vm_networks
      # Assuming you have a method to fetch VM networks from vCenter
      Vcenter.all.map(&:vm_networks).flatten
    end
  end
  
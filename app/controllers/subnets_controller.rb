class SubnetsController < ApplicationController
  before_action :set_subnet, only: [:show, :edit, :update, :destroy]

  # GET /subnets
  def index
    @subnets = Subnet.all
  end

  # GET /subnets/new
  def new
    @subnet = Subnet.new
    @vm_networks = fetch_vm_networks
  end

  # GET /subnets/1/edit
  def edit
    @vm_networks = fetch_vm_networks
  end

  # POST /subnets
  def create
    @subnet = Subnet.new(subnet_params)
    if @subnet.save
      redirect_to subnets_path, notice: 'Subnet was successfully created.'
    else
      @vm_networks = fetch_vm_networks
      render :new
    end
  end

  # PATCH/PUT /subnets/1
  def update
    if @subnet.update(subnet_params)
      redirect_to subnets_path, notice: 'Subnet was successfully updated.'
    else
      @vm_networks = fetch_vm_networks
      render :edit
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_subnet
    @subnet = Subnet.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def subnet_params
    params.require(:subnet).permit(:name, :address, :cidr, :mask, :gateway, :dns1, :dns2, :vm_network_id)
  end

  def fetch_vm_networks
    # Adjust this method to fetch VM networks as needed
    Vcenter.all.map { |vc| vc.networks }.flatten
  end
end

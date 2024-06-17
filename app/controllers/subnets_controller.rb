class SubnetsController < ApplicationController
  before_action :set_subnet, only: [:edit, :update, :destroy]

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

  # DELETE /subnets/1
  def destroy
    @subnet.destroy
    redirect_to subnets_path, notice: 'Subnet was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_subnet
    @subnet = Subnet.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def subnet_params
    params.require(:subnet).permit(:name, :address, :cidr, :mask, :gateway, :dns1, :dns2, :vm_network)
  end

  def fetch_vm_networks
    Network.all.pluck(:name, :id)
  end
end

# app/controllers/subnets_controller.rb
class SubnetsController < ApplicationController
  before_action :set_subnet, only: [:show, :edit, :update, :destroy]

  def index
    @subnets = Subnet.all
  end

  def show
  end

  def new
    @subnet = Subnet.new
    @vm_networks = VmNetwork.all # Assuming you have a VmNetwork model
  end

  def create
    @subnet = Subnet.new(subnet_params)
    if @subnet.save
      redirect_to @subnet, notice: 'Subnet was successfully created.'
    else
      render :new
    end
  end

  def edit
    @vm_networks = VmNetwork.all # Assuming you have a VmNetwork model
  end

  def update
    if @subnet.update(subnet_params)
      redirect_to @subnet, notice: 'Subnet was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @subnet.destroy
    redirect_to subnets_url, notice: 'Subnet was successfully destroyed.'
  end

  private

  def set_subnet
    @subnet = Subnet.find(params[:id])
  end

  def subnet_params
    params.require(:subnet).permit(:name, :address, :cidr, :mask, :gateway, :dns1, :dns2, :vm_network_id)
  end
end

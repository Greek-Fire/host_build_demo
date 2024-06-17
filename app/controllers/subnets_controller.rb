# app/controllers/subnets_controller.rb

class SubnetsController < ApplicationController
  before_action :set_subnet, only: [:edit, :update, :destroy]

  def index
    @subnets = Subnet.all
  end

  def new
    @subnet = Subnet.new
    @vm_networks = VmNetwork.all
  end

  def create
    @subnet = Subnet.new(subnet_params)
    if @subnet.save
      redirect_to subnets_path, notice: 'Subnet was successfully created.'
    else
      @vm_networks = VmNetwork.all
      render :new
    end
  end

  def edit
    @vm_networks = VmNetwork.all
  end

  def update
    if @subnet.update(subnet_params)
      redirect_to subnets_path, notice: 'Subnet was successfully updated.'
    else
      @vm_networks = VmNetwork.all
      render :edit
    end
  end

  def destroy
    @subnet.destroy
    redirect_to subnets_path, notice: 'Subnet was successfully deleted.'
  end

  private

  def set_subnet
    @subnet = Subnet.find(params[:id])
  end

  def

# app/controllers/vcenters_controller.rb
class VcentersController < ApplicationController
  before_action :set_vcenter, only: [:show, :edit, :update, :destroy]

  def index
    @vcenters = Vcenter.all
  end

  def show
  end

  def new
    @vcenter = Vcenter.new
  end

  def create
    @vcenter = Vcenter.new(vcenter_params)
    if @vcenter.save
      redirect_to @vcenter, notice: 'Vcenter was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @vcenter.update(vcenter_params)
      redirect_to @vcenter, notice: 'Vcenter was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @vcenter.destroy
    redirect_to vcenters_url, notice: 'Vcenter was successfully destroyed.'
  end

  private

  def set_vcenter
    @vcenter = Vcenter.find(params[:id])
  end

  def vcenter_params
    params.require(:vcenter).permit(:name, :fqdn, :location)
  end
end

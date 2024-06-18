# app/controllers/vcenters_controller.rb
class VcentersController < ApplicationController
  before_action :set_vcenter, only: [:show, :edit, :update, :destroy]

  def index
    @vcenters = Vcenter.all
  end

  def show
  end

  def fetch_vcenters
    VcenterFetcher.new.run # Assuming you have a method `run` in VcenterFetcher
    redirect_to vcenters_path, notice: 'Vcenters are being fetched and updated.'
  rescue StandardError => e
    redirect_to vcenters_path, alert: "Failed to fetch vCenters: #{e.message}"
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

  # app/controllers/vcenters_controller.rb
  def destroy
    @vcenter = Vcenter.find(params[:id])
    @vcenter.destroy
    redirect_to vcenters_path, notice: 'Vcenter was successfully destroyed.'
  rescue ActiveRecord::RecordNotFound
    redirect_to vcenters_path, alert: 'Vcenter not found.'
  end


  private

  def set_vcenter
    @vcenter = Vcenter.find(params[:id])
  end

  def vcenter_params
    params.require(:vcenter).permit(:name, :fqdn, :location)
  end
end

class Subnet < ApplicationRecord
    belongs_to :vm_network
  
    validates :name, :address, :cidr, :mask, :gateway, :dns1, :dns2, presence: true
  end
  
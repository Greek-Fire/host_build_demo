# app/models/subnet.rb

class Subnet < ApplicationRecord
  belongs_to :vm_network

  validates :name, :address, :cidr, :mask, :gateway, :dns1, :dns2, presence: true
  validates :cidr, format: { with: /\A(\d{1,3}\.){3}\d{1,3}\/\d{1,2}\z/, message: "must be a valid CIDR notation" }
  validates :address, :gateway, :dns1, :dns2, format: { with: Resolv::IPv4::Regex, message: "must be a valid IP address" }
end

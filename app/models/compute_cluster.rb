class ComputeCluster < ApplicationRecord
  belongs_to :datacenter
  has_many :vm_networks
  has_many :esx_hosts
end
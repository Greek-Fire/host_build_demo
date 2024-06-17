class ComputeCluster < ApplicationRecord
  belongs_to :datacenter
  has_many :datastores, dependent: :destroy
  has_many :vm_networks, dependent: :destroy
end

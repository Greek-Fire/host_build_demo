class ComputeCluster < ApplicationRecord
  belongs_to :datacenter
  has_many :vm_networks, dependent: :destroy
end
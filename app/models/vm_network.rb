class VmNetwork < ApplicationRecord
  belongs_to :compute_cluster
  has_many :subnets, dependent: :destroy
end

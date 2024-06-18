class VmNetwork < ApplicationRecord
  belongs_to :compute_cluster
  has_many :virtual_machines
end
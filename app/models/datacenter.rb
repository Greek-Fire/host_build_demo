class Datacenter < ApplicationRecord
  belongs_to :vcenter
  has_many :compute_clusters, dependent: :destroy
end
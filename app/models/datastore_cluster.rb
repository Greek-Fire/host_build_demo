class DatastoreCluster < ApplicationRecord
  belongs_to :datacenter
  has_many :datastores
end
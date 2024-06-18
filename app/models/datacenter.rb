# app/models/datacenter.rb
class Datacenter < ApplicationRecord
  belongs_to :vcenter
  has_many :compute_clusters
  has_many :datastore_clusters
end

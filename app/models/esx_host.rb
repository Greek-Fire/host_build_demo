# app/models/esx_host.rb
class EsxHost < ApplicationRecord
  belongs_to :compute_cluster
end
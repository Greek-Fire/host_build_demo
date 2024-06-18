# app/models/datastore.rb
class Datastore < ApplicationRecord
  belongs_to :datastore_cluster, optional: true
end
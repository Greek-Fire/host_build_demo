class Vcenter < ApplicationRecord
    has_many :datacenters
    has_many :credentials
  end
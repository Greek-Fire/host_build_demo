class VmNetwork < ApplicationRecord
    has_many :subnets
  
    validates :name, presence: true
  end
  
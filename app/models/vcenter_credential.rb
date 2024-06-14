class VcenterCredential < ApplicationRecord
  belongs_to :vcenter

  validates :vcenter_id, presence: true
  validates :username, presence: true, uniqueness: { scope: :vcenter_id, message: "has already been taken for this vCenter" }
  validates :password, presence: true
end


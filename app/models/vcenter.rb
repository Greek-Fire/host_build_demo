class Vcenter < ApplicationRecord
  has_many :vcenter_credentials, dependent: :destroy

  validates :name, presence: true, uniqueness: { message: "has already been taken" }
  validates :url, presence: true, uniqueness: { message: "has already been taken" }, format: { with: /\A[^http|https].*\z/, message: "must not start with http:// or https://" }
end


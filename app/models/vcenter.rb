class Vcenter < ApplicationRecord
  has_many :vcenter_credentials, dependent: :destroy

  validates :name, presence: true, uniqueness: { message: "has already been taken" }
  validates :url, presence: true, uniqueness: { message: "has already been taken" }, format: { with: /\A[^http|https].*\z/, message: "must not start with http:// or https://" }
  def networks
    credential = vcenter_credentials.first
    return [] unless credential

    connection = Fog::Compute.new(
      provider: 'Vsphere',
      vsphere_username: credential.username,
      vsphere_password: credential.password,
      vsphere_server: url,
      vsphere_ssl: credential.ssl_verification,
      vsphere_expected_pubkey_hash: 'a7401d408f9a4ac60848fe34242a9a9c89fcfb73231b2053f64540e8fb03721e',
      vsphere_insecure: !credential.ssl_verification
    )

    connection.networks.all.map(&:name)
  rescue => e
    Rails.logger.error("Failed to fetch networks: #{e.message}")
    []
  end
end


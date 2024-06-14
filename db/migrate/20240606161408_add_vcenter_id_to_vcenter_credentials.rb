class AddVcenterIdToVcenterCredentials < ActiveRecord::Migration[6.0]
  def change
    add_column :vcenter_credentials, :vcenter_id, :integer
    add_index :vcenter_credentials, :vcenter_id
  end
end


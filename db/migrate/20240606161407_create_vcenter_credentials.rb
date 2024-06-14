class CreateVcenterCredentials < ActiveRecord::Migration[7.1]
  def change
    create_table :vcenter_credentials do |t|
      t.string :vsphere_server
      t.string :username
      t.string :password
      t.boolean :ssl_verification

      t.timestamps
    end
  end
end

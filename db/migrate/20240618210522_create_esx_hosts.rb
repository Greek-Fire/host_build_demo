class CreateEsxHosts < ActiveRecord::Migration[7.1]
  def change
    create_table :esx_hosts do |t|
      t.string :name
      t.string :ip_address
      t.references :compute_cluster, null: false, foreign_key: true

      t.timestamps
    end
  end
end

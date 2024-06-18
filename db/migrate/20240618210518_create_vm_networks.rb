class CreateVmNetworks < ActiveRecord::Migration[7.1]
  def change
    create_table :vm_networks do |t|
      t.string :name
      t.references :compute_cluster, null: false, foreign_key: true

      t.timestamps
    end
  end
end

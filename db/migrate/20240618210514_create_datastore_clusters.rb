class CreateDatastoreClusters < ActiveRecord::Migration[7.1]
  def change
    create_table :datastore_clusters do |t|
      t.string :name
      t.integer :total_storage
      t.references :datacenter, null: false, foreign_key: true

      t.timestamps
    end
  end
end

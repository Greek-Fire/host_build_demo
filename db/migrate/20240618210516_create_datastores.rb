class CreateDatastores < ActiveRecord::Migration[7.1]
  def change
    create_table :datastores do |t|
      t.string :name
      t.integer :storage_capacity
      t.references :datastore_cluster, null: false, foreign_key: true

      t.timestamps
    end
  end
end

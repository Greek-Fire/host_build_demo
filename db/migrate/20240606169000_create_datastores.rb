class CreateDatastores < ActiveRecord::Migration[6.1]
  def change
    create_table :datastores do |t|
      t.string :name
      t.string :type
      t.integer :capacity
      t.references :compute_cluster, null: false, foreign_key: true

      t.timestamps
    end
  end
end

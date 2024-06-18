class CreateComputeClusters < ActiveRecord::Migration[7.1]
  def change
    create_table :compute_clusters do |t|
      t.string :name
      t.integer :total_memory
      t.integer :total_cores
      t.integer :total_storage
      t.references :datacenter, null: false, foreign_key: true

      t.timestamps
    end
  end
end

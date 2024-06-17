class CreateComputeClusters < ActiveRecord::Migration[6.1]
  def change
    create_table :compute_clusters do |t|
      t.string :name
      t.references :datacenter, null: false, foreign_key: true

      t.timestamps
    end
  end
end

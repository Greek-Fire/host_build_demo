class CreateDatacenters < ActiveRecord::Migration[7.1]
  def change
    create_table :datacenters do |t|
      t.string :name
      t.references :vcenter, null: false, foreign_key: true

      t.timestamps
    end
  end
end

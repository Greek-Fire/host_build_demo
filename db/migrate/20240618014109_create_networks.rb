class CreateNetworks < ActiveRecord::Migration[7.1]
  def change
    create_table :networks do |t|
      t.string :name
      t.references :vcenter, null: false, foreign_key: true

      t.timestamps
    end
  end
end

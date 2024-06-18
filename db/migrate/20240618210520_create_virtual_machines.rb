class CreateVirtualMachines < ActiveRecord::Migration[7.1]
  def change
    create_table :virtual_machines do |t|
      t.string :name
      t.string :ip_address
      t.references :vm_network, null: false, foreign_key: true

      t.timestamps
    end
  end
end

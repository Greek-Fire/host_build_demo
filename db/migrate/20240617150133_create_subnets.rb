class CreateSubnets < ActiveRecord::Migration[6.0]
  def change
    create_table :subnets do |t|
      t.string :name
      t.string :address
      t.string :cidr
      t.string :mask
      t.string :gateway
      t.string :dns1
      t.string :dns2
      t.references :vm_network, foreign_key: true

      t.timestamps
    end
  end
end

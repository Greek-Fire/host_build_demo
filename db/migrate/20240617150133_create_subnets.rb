class CreateSubnets < ActiveRecord::Migration[7.1]
  def change
    create_table :subnets do |t|
      t.string :name
      t.string :address
      t.string :cidr
      t.string :mask
      t.string :gateway
      t.string :dns1
      t.string :dns2
      t.string :vm_network

      t.timestamps
    end
  end
end

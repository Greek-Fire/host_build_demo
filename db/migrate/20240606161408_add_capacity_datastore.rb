class AddCapacityToDatastores < ActiveRecord::Migration[6.1]
  def change
    add_column :datastores, :capacity, :integer
  end
end

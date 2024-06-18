class CreateCredentials < ActiveRecord::Migration[7.1]
  def change
    create_table :credentials do |t|
      t.string :username
      t.string :password
      t.boolean :ssl_verification
      t.string :source
      t.references :vcenter, null: false, foreign_key: true

      t.timestamps
    end
  end
end

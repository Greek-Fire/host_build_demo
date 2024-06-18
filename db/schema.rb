# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_18_210524) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "compute_clusters", force: :cascade do |t|
    t.string "name"
    t.integer "total_memory"
    t.integer "total_cores"
    t.integer "total_storage"
    t.bigint "datacenter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["datacenter_id"], name: "index_compute_clusters_on_datacenter_id"
  end

  create_table "credentials", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.boolean "ssl_verification"
    t.string "source"
    t.bigint "vcenter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vcenter_id"], name: "index_credentials_on_vcenter_id"
  end

  create_table "datacenters", force: :cascade do |t|
    t.string "name"
    t.bigint "vcenter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vcenter_id"], name: "index_datacenters_on_vcenter_id"
  end

  create_table "datastore_clusters", force: :cascade do |t|
    t.string "name"
    t.integer "total_storage"
    t.bigint "datacenter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["datacenter_id"], name: "index_datastore_clusters_on_datacenter_id"
  end

  create_table "datastores", force: :cascade do |t|
    t.string "name"
    t.integer "storage_capacity"
    t.bigint "datastore_cluster_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["datastore_cluster_id"], name: "index_datastores_on_datastore_cluster_id"
  end

  create_table "esx_hosts", force: :cascade do |t|
    t.string "name"
    t.string "ip_address"
    t.bigint "compute_cluster_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["compute_cluster_id"], name: "index_esx_hosts_on_compute_cluster_id"
  end

  create_table "vcenters", force: :cascade do |t|
    t.string "name"
    t.string "fqdn"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "virtual_machines", force: :cascade do |t|
    t.string "name"
    t.string "ip_address"
    t.bigint "vm_network_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vm_network_id"], name: "index_virtual_machines_on_vm_network_id"
  end

  create_table "vm_networks", force: :cascade do |t|
    t.string "name"
    t.bigint "compute_cluster_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["compute_cluster_id"], name: "index_vm_networks_on_compute_cluster_id"
  end

  add_foreign_key "compute_clusters", "datacenters"
  add_foreign_key "credentials", "vcenters"
  add_foreign_key "datacenters", "vcenters"
  add_foreign_key "datastore_clusters", "datacenters"
  add_foreign_key "datastores", "datastore_clusters"
  add_foreign_key "esx_hosts", "compute_clusters"
  add_foreign_key "virtual_machines", "vm_networks"
  add_foreign_key "vm_networks", "compute_clusters"
end

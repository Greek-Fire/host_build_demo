# your_script.rb

# Load VMwareClient class from vmware_client.rb
require_relative 'VmwareClient'

# Replace with your vSphere connection details
vcenter_host = 'vcenter.lou.land'
username = 'administrator@lou.land'
password = 'Gr33k*G0d7'


# Instantiate VMwareClient with connection details
client = VMware Client.new(host: vcenter_host, user: username, password: password)

# Collect and print detailed information about datacenters
begin
  datacenters = client.collect_datacenters
  datacenters.each do |dc|
    puts "Datacenter: #{dc[:name]}"
    dc[:datastore_clusters].each do |dsc|
      puts "  Datastore Cluster: #{dsc[:name]}, Total Storage: #{dsc[:total_storage]}"
    end
    dc[:compute_clusters].each do |cc|
      puts "  Compute Cluster: #{cc[:name]}"
      cc[:vm_networks].each do |net|
        puts "    VM Network: #{net[:name]}, VMs: #{net[:vms].join(', ')}"
      end
      cc[:hosts].each do |host|
        puts "    Host: #{host[:name]}, IP: #{host[:ip_address]}"
      end
    end
    dc[:datastores].each do |ds|
      puts "  Datastore: #{ds[:name]}, Free Space: #{ds[:free_space]}, Capacity: #{ds[:capacity]}"
    end
  end
rescue StandardError => e
  puts "Error: #{e.message}"
ensure
  client.disconnect
end
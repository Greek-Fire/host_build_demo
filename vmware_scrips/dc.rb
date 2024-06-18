# your_script.rb

# Load VMwareClient class from vmware_client.rb
require_relative 'VmwareClient'

# Replace with your vSphere connection details
vcenter_host = 'vcenter.lou.land'
username = 'administrator@lou.land'
password = 'Gr33k*G0d7'

# dc_container.rb
# Instantiate VMwareClient with connection details
client = VMwareClient.new(host: vcenter_host, user: username, password: password)

# Example: Collect and print detailed information about datacenters
begin
  datacenters = client.collect_datacenters
  datacenters.each do |dc|
    puts "Datacenter: #{dc[:name]}, Clusters: #{dc[:clusters]}, Hosts: #{dc[:hosts]}, VMs: #{dc[:vms]}"
  end
rescue StandardError => e
  puts "Error: #{e.message}"
ensure
  # Disconnect from vSphere
  client.disconnect
end

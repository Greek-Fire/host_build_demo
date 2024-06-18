# your_script.rb

# Load VMwareClient class from vmware_client.rb
require_relative 'VmwareClient'

# Replace with your vSphere connection details
vcenter_host = 'vcenter.lou.land'
username = 'administrator@lou.land'
password = 'Gr33k*G0d7'

client = VMwareClient.new(host: vcenter_host, user: username, password: password)

# Example: Collect and print datacenters
begin
  datacenters = client.collect_datacenters
  puts "Datacenters: #{datacenters.join(', ')}"
rescue StandardError => e
  puts "Error: #{e.message}"
ensure
  # Disconnect from vSphere
  client.disconnect
end
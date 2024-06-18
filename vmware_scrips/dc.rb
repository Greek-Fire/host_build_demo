# your_script.rb

# Load VMwareClient class from vmware_client.rb
require_relative 'VmwareClient'

# Replace with your vSphere connection details
vcenter_host = 'vcenter.lou.land'
username = 'administrator@lou.land'
password = 'Gr33k*G0d7'

# Instantiate VMwareClient with connection details
client = VMwareClient.new(host: vcenter_host, user: username, password: password)

# Example: Collect and print datacenters
begin
  datacenters = client.collect_datacenters
  puts "Datacenters: #{datafaces.join(', ')}"
rescue StandardError => e
  puts "Error: #{e.message}"
ensure
  # Ensure to disconnect from vSphere after operation
  client.disconnect
end
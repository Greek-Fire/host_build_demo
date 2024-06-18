# your_script.rb

# Load VMwareClient class from vmware_client.rb
require_relative 'VmwareClient'

# Replace with your vSphere connection details
vcenter_host = 'vcenter.lou.land'
username = 'administrator@lou.land'
password = 'Gr33k*G0d7'

# Instantiate VMwareClient with connection details
client = VMwareClient.new(host: vcenter_host, user: username, password: password)

# Collect and print detailed information about datacenters with structured format
begin
  datacenters = client.collect_datacenters
  datacenters.each do |dc|
    puts "\nDatacenter: #{dc[:name]}"
    puts "---------------------------------------"
    dc[:datastore_clusters].each do |dsc|
      puts "\n  Datastore Cluster: #{dsc[:name]}, Total Storage: #{format_bytes(dsc[:total_storage])}"
      dsc[:datastores].each do |ds|
        puts "    Datastore: #{ds[:name]}, Capacity: #{format_bytes(ds[:capacity])}, Free Space: #{format_bytes(ds[:free_space])}"
      end
    end
    dc[:compute_clusters].each do |cc|
      puts "\n  Compute Cluster: #{cc[:name]}"
      cc[:vm_networks].each do |net|
        puts "    VM Network: #{net[:name]}, VMs: #{net[:vms].join(', ')}"
      end
      cc[:hosts].each do |host|
        puts "    Host: #{host[:name]}, IP: #{host[:ip_address]}"
        host[:vm_networks].each do |net|
          puts "      VM Network on Host: #{net}"
        end
      end
    end
    dc[:datastores].each do |ds|
      puts "\n  Standalone Datastore: #{ds[:name]}, Capacity: #{format_bytes(ds[:capacity])}, Free Space: #{format_bytes(ds[:free_space])}"
    end
  end
rescue StandardError => e
  puts "\nError: #{e.message}"
ensure
  # Ensure to disconnect from vSphere
  client.disconnect
end

# Helper method to format bytes into a more readable format
def format_bytes(bytes)
  {
    'B'  => 1024,
    'KB' => 1024 * 1024,
    'MB' => 1024 * 1024 * 1024,
    'GB' => 1024 * 1024 * 1024 * 1024,
    'TB' => 1024 * 1024 * 1024 * 1024 * 1024
  }.each_pair { |e, s| return "#{(bytes.to_f / (s / 1024)).round(2)} #{e}" if bytes < s }
end

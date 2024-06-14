require 'fog/vsphere'

def verify_vcenter_credentials(host, user, pass, inse)
  begin
    connection = Fog::Compute.new(
      provider: 'Vsphere',
      vsphere_username: user,
      vsphere_password: pass,
      vsphere_server: host,
      vsphere_ssl: inse,
      #vsphere_expected_pubkey_hash: 'a7401d408f9a4ac60848fe34242a9a9c89fcfb73231b2053f64540e8fb03721e',  # Ensure this is what you intend (nil means no pubkey check)
      vsphere_insecure: !inse
    )
    # Assuming you can retrieve version info from the connection
    version = connection.instance_variable_get(:@vsphere_rev)  # Adapt based on actual available methods
    puts "Connected to vCenter at #{host} successfully."
    puts "vCenter version: #{version}"
    true
  rescue Fog::Vsphere::Errors::SecurityError => e
    puts "Security error during vCenter credential verification: #{e.message}"
    false
  rescue => e
    puts "Unexpected error during vCenter credential verification: #{e.cgi_escape_message}"
    false
  end
end

if ARGV.length != 4
  puts "Usage: ruby vcenter_verify.rb <host> <username> <password> <ssl_verification>"
  puts "Example: ruby vcenter_verify.rb vcenter.lou.land administrator@lou.land 'password' true"
  exit 1
end

host = ARGV[0]
username = ARGV[1]
password = ARGV[2]
ssl_verification = ARGV[3].downcase == 'true'

puts "Attempting to connect to vCenter at #{host} with username #{username}"

verify_vcenter_credentials(host, username, password, ssl_verification)


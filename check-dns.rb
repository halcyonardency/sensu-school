#!/usr/bin/env ruby
#
#  check-dns
#
# DESCRIPTION:
#   This check will verify a host resolves to the right IP.
#   * This version just hnadles singleton A-record validation
#
# OUTPUT:
#   plain text
#
# PLATFORMS:
#   Linux
#
# DEPENDENCIES:
#   gem: sensu-plugin
#
# USAGE:
#   check-dns.rb -h HOSTNAME -i EXPECTED_IP
#
# NOTES:
#
# LICENSE:
#   Released under the same terms as Sensu (the MIT license); see LICENSE
#   for details.
#

require 'rubygems' if RUBY_VERSION < '1.9.0'
require 'sensu-plugin/check/cli'
require 'resolv'

class CheckDNS < Sensu::Plugin::Check::CLI

### set options for this sensu checks
  option :host,
         short: '-h host',
	 long: '--host HOST',
         default: 'localhost.localdomain',
	 required: true

  option :ip,
         short: '-i ip',
	 long: '--ip IP',
         description: 'This ip address to validate',
         default: '127.0.0.1',
	 required: true

### input hostname, return ip or resolver errror
  def hostname_to_ip hostname
    begin 
      ip = Resolv.getaddress(config[:host])
    rescue Resolv::ResolvError => resolv_err
      raise Exception.new("Resolver error: #{resolv_err}")
    end
    return ip
  end

### check_dns, handle results
  def check_dns
    begin 
      ip = hostname_to_ip config[:host]
    rescue Exception => e
      message = "Error in resolver: #{e.inspect}"
      critical message
    end
    
    if config[:ip].eql? ip
      message = "#{config[:host]} resolves to #{config[:ip]}"
      ok message
    else
      message = "#{config[:host]} does not resolve to #{config[:ip]}: (#{ip})"
      critical message
    end

  end

### run, main execution
  def run
    check_dns
  end

end

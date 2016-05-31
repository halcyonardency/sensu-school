#!/usr/bin/env ruby
#
#  check-XXX
#
# DESCRIPTION:
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
#
# NOTES:
#
# LICENSE:
#   Released under the same terms as Sensu (the MIT license); see LICENSE
#   for details.
#

require 'rubygems' if RUBY_VERSION < '1.9.0'
require 'sensu-plugin/check/cli'

class CheckXXX < Sensu::Plugin::Check::CLI

### set options for this sensu check
  option :xxx,
         short: '-x XXX',
         default: 'XXX',
	 required: false

### run, main execution
  def run
    ok
  end

end

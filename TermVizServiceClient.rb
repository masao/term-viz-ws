#!/usr/bin/env ruby
require 'TermVizDriver.rb'

endpointUrl = ARGV.shift || TermVizPort::DefaultEndpointUrl
proxyUrl = ENV[ 'http_proxy' ] || ENV[ 'HTTP_PROXY' ]
obj = TermVizPort.new( endpointUrl, proxyUrl )

# Uncomment the below line to see SOAP wiredumps.
# obj.setWireDumpDev( STDERR )


# SYNOPSIS
#   wordSearch( term, target )
#
# ARGS
#   term		String - {http://www.w3.org/2001/XMLSchema}string
#   target		String - {http://www.w3.org/2001/XMLSchema}string
#
# RETURNS
#   return		String - {http://www.w3.org/2001/XMLSchema}string
#
# RAISES
#    N/A
#
term = target = nil
puts obj.wordSearch( term, target )

# SYNOPSIS
#   idSearch( id )
#
# ARGS
#   id		String - {http://www.w3.org/2001/XMLSchema}string
#
# RETURNS
#   return		String - {http://www.w3.org/2001/XMLSchema}string
#
# RAISES
#    N/A
#
id = nil
puts obj.idSearch( id )



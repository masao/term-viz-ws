#!/usr/bin/env ruby
require 'GraphVizDriver.rb'

endpointUrl = ARGV.shift || GraphVizPort::DefaultEndpointUrl
proxyUrl = ENV[ 'http_proxy' ] || ENV[ 'HTTP_PROXY' ]
obj = GraphVizPort.new( endpointUrl, proxyUrl )

# Uncomment the below line to see SOAP wiredumps.
# obj.setWireDumpDev( STDERR )


# SYNOPSIS
#   doGraphViz( dot, format )
#
# ARGS
#   dot		 - {http://www.w3.org/2001/XMLSchema}base64Binary
#   format		 - {http://www.w3.org/2001/XMLSchema}string
#
# RETURNS
#   return		 - {http://www.w3.org/2001/XMLSchema}base64Binary
#
# RAISES
#    N/A
#
dot = format = nil
puts obj.doGraphViz( dot, format )



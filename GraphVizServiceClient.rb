#!/usr/local/bin/ruby
require 'GraphVizDriver.rb'

endpointUrl = ARGV.shift || GraphVizPort::DefaultEndpointUrl
proxyUrl = ENV[ 'http_proxy' ] || ENV[ 'HTTP_PROXY' ]
obj = GraphVizPort.new( endpointUrl, proxyUrl )

# Uncomment the below line to see SOAP wiredumps.
# obj.setWireDumpDev( STDERR )


# SYNOPSIS
#   doGraphViz( wordlist, rankdir, format )
#
# ARGS
#   wordlist		WordArray - {urn:GraphViz}WordArray
#   rankdir		 - {http://www.w3.org/2001/XMLSchema}string
#   format		 - {http://www.w3.org/2001/XMLSchema}string
#
# RETURNS
#   return		 - {http://www.w3.org/2001/XMLSchema}base64Binary
#
# RAISES
#    N/A
#
wordlist = rankdir = format = nil
puts obj.doGraphViz( wordlist, rankdir, format )



#!/usr/local/bin/ruby
require 'TermVizDriver.rb'

endpointUrl = ARGV.shift || TermVizPort::DefaultEndpointUrl
proxyUrl = ENV[ 'http_proxy' ] || ENV[ 'HTTP_PROXY' ]
obj = TermVizPort.new( endpointUrl, proxyUrl )

# Uncomment the below line to see SOAP wiredumps.
# obj.setWireDumpDev( STDERR )


# SYNOPSIS
#   doWordSearch( term )
#
# ARGS
#   term		 - {http://www.w3.org/2001/XMLSchema}string
#
# RETURNS
#   return		WordSearchResult - {urn:TermViz}WordSearchResult
#
# RAISES
#    N/A
#
term = nil
puts obj.doWordSearch( term )

# SYNOPSIS
#   getWordList( id )
#
# ARGS
#   id		 - {http://www.w3.org/2001/XMLSchema}string
#
# RETURNS
#   return		WordArray - {urn:TermViz}WordArray
#
# RAISES
#    N/A
#
id = nil
puts obj.getWordList( id )



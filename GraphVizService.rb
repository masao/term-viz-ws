#!/usr/bin/env ruby
require 'GraphVizServant.rb'

require 'soap/standaloneServer'

class GraphVizPort
  require 'soap/rpcUtils'
  MappingRegistry = SOAP::RPCUtils::MappingRegistry.new

  
  Methods = [
    [ "doGraphViz", "doGraphViz", [
      [ "in", "dot",
        [ SOAP::SOAPBase64 ] ],
      [ "in", "format",
        [ SOAP::SOAPString ] ],
      [ "retval", "return",
        [ SOAP::SOAPBase64 ] ] ],
      "urn:GraphVizAction", "urn:GraphViz" ]
  ]
end

class App < SOAP::StandaloneServer
  def initialize( *arg )
    super( *arg )

    servant = GraphVizPort.new
    GraphVizPort::Methods.each do | methodNameAs, methodName, params, soapAction, namespace |
      addMethodWithNSAs( namespace, servant, methodName, methodNameAs, params, soapAction )
    end

    self.mappingRegistry = GraphVizPort::MappingRegistry
    setSevThreshold( Devel::Logger::ERROR )
  end
end

# Change listen port.
App.new( 'app', nil, '0.0.0.0', 10080 ).start

#!/usr/local/bin/ruby
require 'GraphVizServant.rb'

require 'soap/standaloneServer'

class GraphVizPort
  require 'soap/rpcUtils'
  MappingRegistry = SOAP::RPCUtils::MappingRegistry.new

  MappingRegistry.set(
    WordArray,
    ::SOAP::SOAPArray,
    ::SOAP::RPCUtils::MappingRegistry::TypedArrayFactory,
    { :type => XSD::QName.new( "urn:GraphViz", "Word" ) }
  )
  MappingRegistry.set(
    Word,
    ::SOAP::SOAPStruct,
    ::SOAP::RPCUtils::MappingRegistry::TypedStructFactory,
    { :type => XSD::QName.new( "urn:GraphViz", "Word" ) }
  )
  MappingRegistry.set(
    NodeArray,
    ::SOAP::SOAPArray,
    ::SOAP::RPCUtils::MappingRegistry::TypedArrayFactory,
    { :type => XSD::QName.new( "urn:GraphViz", "Node" ) }
  )
  MappingRegistry.set(
    Node,
    ::SOAP::SOAPStruct,
    ::SOAP::RPCUtils::MappingRegistry::TypedStructFactory,
    { :type => XSD::QName.new( "urn:GraphViz", "Node" ) }
  )
  
  Methods = [
    [ "doGraphViz", "doGraphViz", [
      [ "in", "wordlist",
        [ ::SOAP::SOAPArray, "urn:GraphViz", "Word" ] ],
      [ "in", "rankdir",
        [ SOAP::SOAPString ] ],
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

#!/usr/local/bin/ruby
require 'TermVizServant.rb'

require 'soap/standaloneServer'

class TermVizPort
  require 'soap/rpcUtils'
  MappingRegistry = SOAP::RPCUtils::MappingRegistry.new

  MappingRegistry.set(
    WordSearchResult,
    ::SOAP::SOAPStruct,
    ::SOAP::RPCUtils::MappingRegistry::TypedStructFactory,
    { :type => XSD::QName.new( "urn:TermViz", "WordSearchResult" ) }
  )
  MappingRegistry.set(
    ResultElementArray,
    ::SOAP::SOAPArray,
    ::SOAP::RPCUtils::MappingRegistry::TypedArrayFactory,
    { :type => XSD::QName.new( "urn:TermViz", "ResultElement" ) }
  )
  MappingRegistry.set(
    ResultElement,
    ::SOAP::SOAPStruct,
    ::SOAP::RPCUtils::MappingRegistry::TypedStructFactory,
    { :type => XSD::QName.new( "urn:TermViz", "ResultElement" ) }
  )
  MappingRegistry.set(
    WordArray,
    ::SOAP::SOAPArray,
    ::SOAP::RPCUtils::MappingRegistry::TypedArrayFactory,
    { :type => XSD::QName.new( "urn:TermViz", "Word" ) }
  )
  MappingRegistry.set(
    Word,
    ::SOAP::SOAPStruct,
    ::SOAP::RPCUtils::MappingRegistry::TypedStructFactory,
    { :type => XSD::QName.new( "urn:TermViz", "Word" ) }
  )
  MappingRegistry.set(
    NodeArray,
    ::SOAP::SOAPArray,
    ::SOAP::RPCUtils::MappingRegistry::TypedArrayFactory,
    { :type => XSD::QName.new( "urn:TermViz", "Node" ) }
  )
  MappingRegistry.set(
    Node,
    ::SOAP::SOAPStruct,
    ::SOAP::RPCUtils::MappingRegistry::TypedStructFactory,
    { :type => XSD::QName.new( "urn:TermViz", "Node" ) }
  )
  
  Methods = [
    [ "doWordSearch", "doWordSearch", [
      [ "in", "term",
        [ SOAP::SOAPString ] ],
      [ "retval", "return",
        [ ::SOAP::SOAPStruct, "urn:TermViz", "WordSearchResult" ] ] ],
      "urn:TermVizAction", "urn:TermViz" ],
    [ "getWordList", "getWordList", [
      [ "in", "id",
        [ SOAP::SOAPString ] ],
      [ "retval", "return",
        [ ::SOAP::SOAPArray, "urn:TermViz", "Word" ] ] ],
      "urn:TermVizAction", "urn:TermViz" ]
  ]
end

class App < SOAP::StandaloneServer
  def initialize( *arg )
    super( *arg )

    servant = TermVizPort.new
    TermVizPort::Methods.each do | methodNameAs, methodName, params, soapAction, namespace |
      addMethodWithNSAs( namespace, servant, methodName, methodNameAs, params, soapAction )
    end

    self.mappingRegistry = TermVizPort::MappingRegistry
    setSevThreshold( Devel::Logger::ERROR )
  end
end

# Change listen port.
App.new( 'app', nil, '0.0.0.0', 10080 ).start

#!/usr/local/bin/ruby
require 'TermServant.rb'

require 'soap/standaloneServer'

class TermPort
  require 'soap/rpcUtils'
  MappingRegistry = SOAP::RPCUtils::MappingRegistry.new

  MappingRegistry.set(
    WordSearchResult,
    ::SOAP::SOAPStruct,
    ::SOAP::RPCUtils::MappingRegistry::TypedStructFactory,
    { :type => XSD::QName.new( "urn:Term", "WordSearchResult" ) }
  )
  MappingRegistry.set(
    NodeArray,
    ::SOAP::SOAPArray,
    ::SOAP::RPCUtils::MappingRegistry::TypedArrayFactory,
    { :type => XSD::QName.new( "urn:Term", "Node" ) }
  )
  MappingRegistry.set(
    Node,
    ::SOAP::SOAPStruct,
    ::SOAP::RPCUtils::MappingRegistry::TypedStructFactory,
    { :type => XSD::QName.new( "urn:Term", "Node" ) }
  )
  MappingRegistry.set(
    WordArray,
    ::SOAP::SOAPArray,
    ::SOAP::RPCUtils::MappingRegistry::TypedArrayFactory,
    { :type => XSD::QName.new( "urn:Term", "Word" ) }
  )
  MappingRegistry.set(
    Word,
    ::SOAP::SOAPStruct,
    ::SOAP::RPCUtils::MappingRegistry::TypedStructFactory,
    { :type => XSD::QName.new( "urn:Term", "Word" ) }
  )
  
  Methods = [
    [ "doWordSearch", "doWordSearch", [
      [ "in", "term",
        [ SOAP::SOAPString ] ],
      [ "retval", "return",
        [ ::SOAP::SOAPStruct, "urn:Term", "WordSearchResult" ] ] ],
      "urn:TermAction", "urn:Term" ],
    [ "getWordList", "getWordList", [
      [ "in", "id",
        [ SOAP::SOAPString ] ],
      [ "retval", "return",
        [ ::SOAP::SOAPArray, "urn:Term", "Word" ] ] ],
      "urn:TermAction", "urn:Term" ]
  ]
end

class App < SOAP::StandaloneServer
  def initialize( *arg )
    super( *arg )

    servant = TermPort.new
    TermPort::Methods.each do | methodNameAs, methodName, params, soapAction, namespace |
      addMethodWithNSAs( namespace, servant, methodName, methodNameAs, params, soapAction )
    end

    self.mappingRegistry = TermPort::MappingRegistry
    setSevThreshold( Devel::Logger::ERROR )
  end
end

# Change listen port.
App.new( 'app', nil, '0.0.0.0', 10080 ).start

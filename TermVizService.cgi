#!/usr/local/bin/ruby
require 'TermVizServant.rb'

require 'soap/cgistub'

class TermVizPort
  require 'soap/rpcUtils'
  MappingRegistry = SOAP::RPCUtils::MappingRegistry.new

  
  Methods = [
    [ "doWordSearch", "doWordSearch", [
      [ "in", "term",
        [ SOAP::SOAPString ] ],
      [ "in", "target",
        [ SOAP::SOAPString ] ],
      [ "retval", "return",
        [ SOAP::SOAPString ] ] ],
      "urn:TermVizAction", "urn:TermViz" ],
    [ "getWordList", "getWordList", [
      [ "in", "id",
        [ SOAP::SOAPString ] ],
      [ "retval", "return",
        [ SOAP::SOAPString ] ] ],
      "urn:TermVizAction", "urn:TermViz" ]
  ]
end

class App < SOAP::CGIStub
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
App.new( 'app', nil ).start

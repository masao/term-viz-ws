require 'Term.rb'

require 'soap/proxy'
require 'soap/rpcUtils'
require 'soap/streamHandler'

class TermPort
  class EmptyResponseError < ::SOAP::Error; end

  MappingRegistry = ::SOAP::RPCUtils::MappingRegistry.new

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

  DefaultEndpointUrl = "http://nile.ulis.ac.jp/~masao/term-viz-ws/TermService.cgi"

  attr_accessor :mappingRegistry
  attr_reader :endPointUrl
  attr_reader :wireDumpDev
  attr_reader :wireDumpFileBase
  attr_reader :httpProxy

  def initialize( endpointUrl = DefaultEndpointUrl, httpProxy = nil )
    @endpointUrl = endpointUrl
    @mappingRegistry = MappingRegistry
    @wireDumpDev = nil
    @dumpFileBase = nil
    @httpProxy = ENV[ 'http_proxy' ] || ENV[ 'HTTP_PROXY' ]
    @handler = ::SOAP::HTTPPostStreamHandler.new( @endpointUrl, @httpProxy,
      ::SOAP::Charset.getEncodingLabel )
    @proxy = ::SOAP::SOAPProxy.new( @namespace, @handler )
    @proxy.allowUnqualifiedElement = true
    addMethod
  end

  def setEndpointUrl( endpointUrl )
    @endpointUrl = endpointUrl
    @handler.endpointUrl = @endpointUrl if @handler
  end

  def setWireDumpDev( dumpDev )
    @wireDumpDev = dumpDev
    @handler.dumpDev = @wireDumpDev if @handler
  end

  def setWireDumpFileBase( base )
    @dumpFileBase = base
  end

  def setHttpProxy( httpProxy )
    @httpProxy = httpProxy
    @handler.proxy = @httpProxy if @handler
  end

  def setDefaultEncodingStyle( encodingStyle )
    @proxy.defaultEncodingStyle = encodingStyle
  end

  def getDefaultEncodingStyle
    @proxy.defaultEncodingStyle
  end

  def call( methodName, *params )
    # Convert parameters: params array => SOAPArray => members array
    params = ::SOAP::RPCUtils.obj2soap( params, @mappingRegistry ).to_a
    header, body = @proxy.call( nil, methodName, *params )
    unless body
      raise EmptyResponseError.new( "Empty response." )
    end

    # Check Fault.
    begin
      @proxy.checkFault( body )
    rescue ::SOAP::FaultError => e
      ::SOAP::RPCUtils.fault2exception( e )
    end

    ret = body.response ?
      ::SOAP::RPCUtils.soap2obj( body.response, @mappingRegistry ) : nil
    if body.outParams
      outParams = body.outParams.collect { | outParam |
	::SOAP::RPCUtils.soap2obj( outParam )
      }
      return [ ret ].concat( outParams )
    else
      return ret
    end
  end

private 

  def addMethod
    Methods.each do | methodNameAs, methodName, params, soapAction, namespace |
      @proxy.addMethodAs( methodNameAs, methodName, params, soapAction,
	namespace )
      addMethodInterface( methodName, params )
    end
  end

  def addMethodInterface( name, params )
    self.instance_eval <<-EOD
      def #{ name }( *params )
	call( "#{ name }", *params )
      end
    EOD
  end
end


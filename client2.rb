#!/usr/local/bin/ruby
# $Id$

require 'soap/wsdlDriver'
require 'uconv'

MY_WSDL = 'http://nile.ulis.ac.jp/~masao/term-viz-ws/edr/term.wsdl'

id = ARGV.shift || "47888"

GC.disable

obj = SOAP::WSDLDriverFactory.new(MY_WSDL).createDriver
obj.resetStream
obj.generateEncodeType = true
obj.setWireDumpFileBase("soap")
obj.setWireDumpDev(File.open("soap-log2", "w"))

result = obj.getWordList(id)


#!/usr/local/bin/ruby
# $Id$

require 'soap/wsdlDriver'
require 'uconv'

MY_WSDL = 'http://nile.ulis.ac.jp/~masao/term-viz-ws/term-viz.wsdl'

obj = SOAP::WSDLDriverFactory.new(MY_WSDL).createDriver
obj.resetStream
obj.setWireDumpFileBase("soap")
obj.setWireDumpDev(File.open("soap-log", "w"))
result = obj.getWordList("47888")

#!/usr/local/bin/ruby -Ku
# $Id$

require 'soap/wsdlDriver'

MY_WSDL = 'http://nile.ulis.ac.jp/~masao/term-viz-ws/term-viz.wsdl'

obj = SOAP::WSDLDriverFactory.new(MY_WSDL).createDriver
result = obj.doWordSearch("情報")

p result

#!/usr/local/bin/ruby
# $Id$

require 'soap/wsdlDriver'

MY_WSDL = 'http://nile.ulis.ac.jp/~masao/term-viz-ws/term-viz.wsdl'

obj = SOAP::WSDLDriverFactory.new(MY_WSDL).createDriver
result = obj.wordSearch("bababa", "hogehoge")

p result

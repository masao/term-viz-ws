#!/usr/local/bin/ruby
# $Id$

GC.disable

require 'soap/wsdlDriver'
require 'uconv'

MY_WSDL = 'http://nile.ulis.ac.jp/~masao/term-viz-ws/term-viz.wsdl'

def search (key)
   obj = SOAP::WSDLDriverFactory.new(MY_WSDL).createDriver
   obj.resetStream
   obj.setWireDumpFileBase("soap")
   obj.setWireDumpDev(File.open("soap-log", "w"))
   obj.doWordSearch(key)
end

key = ARGV.shift || "���󸡺�"
result = search(Uconv.euctou8(key))
puts "��������: #{result.exactMatchElements.size} ��"
puts "��ʬ����: #{result.substrMatchElements.size} ��"

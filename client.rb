#!/usr/local/bin/ruby
# $Id$

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

def usage
   puts "USAGE:  #{$0} keyword ..."
   exit
end

usage() if ARGV.size == 0

ARGV.each do |key|
   result = search(Uconv.euctou8(key))
   puts "窗链办米: #{result.exactMatchElements.size} 凤"
   puts "婶尸办米: #{result.substrMatchElements.size} 凤"
end

#!/usr/local/bin/ruby -Ku
# $Id$

GC.disable	# Ruby1.6系ではなぜか BUS ERROR で落ちるので必要。

require 'Term'
require 'TermUtil'
require 'GraphViz'
require 'soap/wsdlDriver'
require 'uconv'

TERM_WSDL     = 'http://nile.ulis.ac.jp/~masao/term-viz-ws/edr/term.wsdl'
GRAPHVIZ_WSDL = 'http://avalon.ulis.ac.jp/~masao/term-viz-ws/graphviz.wsdl'

id = ARGV.shift || "47888"

term = SOAP::WSDLDriverFactory.new(TERM_WSDL).createDriver
term.generateEncodeType = true
wordlist = term.getWordList(id)
STDERR.puts("getWordList done.")

#  parent = NodeArray.new()
#  parent << Node.new("アウトプット", "2913")
#  parent << Node.new("検索", "29007")
#  child = NodeArray.new()
#  child << Node.new("光学的情報検索", "30645")
#  child << Node.new("選択的情報検索", "55142")
#  child << Node.new("文献情報検索", "95638")
#  word = Word.new("情報検索", "47888", "", parent, child)
#  wordlist = WordArray.new()
#  wordlist.push(word)

obj = SOAP::WSDLDriverFactory.new(GRAPHVIZ_WSDL).createDriver
STDERR.puts "createDriver done."
obj.generateEncodeType = true
obj.resetStream
obj.setWireDumpFileBase("soap")
obj.setWireDumpDev(File.open("soap-log3", "w"))

["png", "dot", "plain"].each do |format|
   result = obj.doGraphViz(wordlist.to_dot, format)
   STDERR.puts "obj.doGraphViz (#{format}) done."
   open("soap_doGraphViz.#{format}", "w") {|f|
      f.print result
   }
   obj.setWireDumpDev(nil)
end

#!/usr/local/bin/ruby -Ku
# $Id$

require 'GraphViz'
require 'soap/wsdlDriver'
require 'uconv'

#TERM_WSDL     = 'http://nile.ulis.ac.jp/~masao/term-viz-ws/term-viz.wsdl'
GRAPHVIZ_WSDL = 'http://nile.ulis.ac.jp/~masao/term-viz-ws/graphviz.wsdl'

#obj = SOAP::WSDLDriverFactory.new(TERM_WSDL).createDriver
#wordlist = obj.getWordList("47888")
#STDERR.puts("getWordList")

parent = NodeArray.new()
parent << Node.new("アウトプット", "2913")
parent << Node.new("検索", "29007")
child = NodeArray.new()
child << Node.new("光学的情報検索", "30645")
child << Node.new("選択的情報検索", "55142")
child << Node.new("文献情報検索", "95638")
word = Word.new("情報検索", "47888", "", parent, child)
wordlist = WordArray.new()
wordlist.push(word)

obj = SOAP::WSDLDriverFactory.new(GRAPHVIZ_WSDL).createDriver
obj.generateEncodeType = true
obj.resetStream
obj.setWireDumpFileBase("soap")
obj.setWireDumpDev(File.open("soap-log3", "w"))

p wordlist
result = obj.doGraphViz(wordlist, "LR", "png")
open("doGraphViz.dot", "w") {|f|
   f.print result
}

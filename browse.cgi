#!/usr/local/bin/ruby -w
# -*- Ruby -*-

GC.disable

require 'soap/wsdlDriver'
require 'cgi'
require 'GraphViz'
require 'TermUtil'

class CGI
   def param(key)
      if self.has_key?(key) && (self[key][0]).length > 0
	 self[key][0]
      else
	 nil
      end
   end
end

class TermService
   attr_reader :name, :wsdl
   def initialize(name, wsdl)
      @name = name
      @wsdl = wsdl
   end
end

TERM_WSDL = {
   'edr' => TermService.new("EDR", 'http://nile.ulis.ac.jp/~masao/term-viz-ws/edr/term.wsdl'),
   'odp' => TermService.new("ODP", 'http://nile.ulis.ac.jp/~masao/term-viz-ws/odp/term.wsdl')
}

GRAPHVIZ_WSDL = 'http://avalon.ulis.ac.jp/~masao/term-viz-ws/graphviz.wsdl'

def html_escape(str)
   CGI.escapeHTML(str.to_s)
end
alias h html_escape

def html_head()
   STDERR.puts "html_head()"
   str = <<EOF
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
	"http://www.w3.org/TR/html4/strict.dtd">
<html lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-JP">
<link rel="stylesheet" href="browse.css" type="text/css">
<link rev=made href="mailto:masao@ulis.ac.jp">
<title>用語体系ブラウジングシステム</title>
</head>
<body>
<h1>用語体系ブラウジングシステム</h1>
<hr>
EOF
end

def html_foot()
   STDERR.puts "html_foot"
   "</body></html>"
end

def html_form(cgi)
   STDERR.puts "html_form"
   result = <<EOF
<div class="form">
<form action="browse.cgi" method="GET">
見出し語検索:
<input type="text" name="term" value="#{h(cgi.param("term") || "")}" size="50">
<select name="target">
EOF
   TERM_WSDL.each_key do |term|
      result << "<option value=\"#{term}\""
      result << " selected" if cgi.param("target") == term
      result << ">#{TERM_WSDL[term].name}\n"
   end
   result << <<EOF
</select>
<input type="submit" value=" Search ">
</form>
</div>
EOF
end

def body(cgi)
   result = ""
   id = cgi.param("id")
   target = cgi.param("target")
   term = cgi.param("term") || ""
   format = cgi.param("format") || "imap"
   rankdir = cgi.param("rankdir") || "LR"
   if id and TERM_WSDL[target]
      obj = SOAP::WSDLDriverFactory.new(TERM_WSDL[target].wsdl).createDriver
      obj.resetStream
      obj.setWireDumpDev(File.open("/tmp/browse_cgi.#{$$}", "a"))
      wordlist = obj.getWordList(id)
      STDERR.puts "getWordList done."
      dot = wordlist.to_dot(rankdir, cgi.script_name << "?target=#{target};format=imap;term=$label;id=$id")

      obj = SOAP::WSDLDriverFactory.new(GRAPHVIZ_WSDL).createDriver
      obj.resetStream
      obj.setWireDumpDev(File.open("/tmp/browse_cgi.#{$$}", "a"))
      obj.generateEncodeType = true
      case format
      when "png", "gif"
	 result = obj.doGraphViz(dot, format)
      when "imap", "cmap"
	 result << "<div class=\"imap\"><map name=\"imap\">\n"
	 result << obj.doGraphViz(dot, "cmap")
	 result << "</map>\n"
	 img_src = "#{cgi.script_name}?target=#{target};format=png;term=#{CGI.escape(term)};id=#{id}"
	 result << "<img src=\"#{img_src}\" usemap=\"#imap\"></div>\n"
      else
	 result << "<pre>"
	 result << obj.doGraphViz(dot, format)
	 result << "</pre>"
      end
      STDERR.puts "doGraphViz done."
   elsif term and TERM_WSDL[target]
      obj = SOAP::WSDLDriverFactory.new(TERM_WSDL[target].wsdl).createDriver
      obj.resetStream
      # obj.setWireDumpDev(File.open("browse_cgi.#{$$}", "w"))
      searched = obj.doWordSearch(term)
      default_format = "imap"
      if searched.exactMatchElements.size > 0
	 result << "<h2>部分一致: #{searched.exactMatchElements.size}件</h2>"
	 result << "<ul>\n"
	 searched.exactMatchElements.each do |node|
	    result << "<li><a href=\"./browse.cgi?id=#{h(node.idref)};target=#{target};format=#{default_format};term=#{h(term)}\">#{node.name}</a>\n"
	 end
	 result << "</ul>"
      end
      if searched.substrMatchElements.size > 0
	 result << "<h2>部分一致: #{searched.substrMatchElements.size}件</h2>"
	 result << "<ul>\n"
	 searched.substrMatchElements.each do |node|
	    result << "<li><a href=\"./browse.cgi?id=#{h(node.idref)};target=#{target};format=#{default_format};term=#{h(term)}\">#{node.name}</a>\n"
	 end
	 result << "</ul>"
      end
   end
   result
end

begin
   if $0 == __FILE__
      cgi = CGI.new
      case cgi.param("format")
      when "png", "gif"
	 cgi.out("image/#{cgi.param("format")}") { body(cgi) }
      else
	 cgi.out("text/html; charset=UTF-8") {
	    html_head() << body(cgi) << html_form(cgi) << html_foot()
	 }
      end
   end
rescue Exception
   print "Content-Type: text/plain\r\n\r\n"
   puts "#$! (#{$!.class})"
   puts ""
   puts $@.join( "\n" )
end

require 'GraphViz.rb'

class GraphVizPort
  # SYNOPSIS
  #   doGraphViz( wordlist, rankdir, format )
  #
  # ARGS
  #   wordlist		WordArray - {urn:GraphViz}WordArray
  #   rankdir		 - {http://www.w3.org/2001/XMLSchema}string
  #   format		 - {http://www.w3.org/2001/XMLSchema}string
  #
  # RETURNS
  #   return		 - {http://www.w3.org/2001/XMLSchema}base64Binary
  #
  # RAISES
  #    N/A
  #
  def doGraphViz( wordlist, rankdir, format )
     return SOAP::SOAPBase64.new(wordlist.to_dot(rankdir))
  end
end

class WordArray
   def to_dot (rankdir = nil)
      retstr = "digraph G {\n"
      retstr << "  graph [rankdir=\"#{rankdir}\"];\n" if rankdir
      self.each do |word|
	 retstr << "  #{word.id} [label=\"#{word.name}\"];\n"
	 word.child.each do |node|
	    retstr << "  #{node.id} [label=\"#{node.name}\"];\n"
	    retstr << "  #{word.id} -> #{node.id}\n"
	 end
	 word.parent.each do |node|
	    retstr << "  #{node.id} [label=\"#{node.name}\"];\n"
	    retstr << "  #{node.id} -> #{word.id}\n"
	 end
      end
      retstr << "}\n"
   end
end

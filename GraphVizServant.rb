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
     dot = wordlist.to_dot(rankdir)
     result = dot_format(dot, format)
     return SOAP::SOAPBase64.new(result)
  end
end

class WordArray
   def to_dot (rankdir = "TB")
      retstr = "digraph G {\n"
      retstr << "  graph [rankdir=\"#{rankdir}\"];\n" if rankdir
      self.each do |word|
	 retstr << "  #{word.id} [label=\"#{word.name}\"];\n"
	 word.child.each do |node|
	    retstr << "  #{node.id} [label=\"#{node.name}\"];\n"
	    retstr << "  #{word.id} -> #{node.id};\n"
	 end
	 word.parent.each do |node|
	    retstr << "  #{node.id} [label=\"#{node.name}\"];\n"
	    retstr << "  #{node.id} -> #{word.id};\n"
	 end
      end
      retstr << "}\n"
   end
end

DOT = "/home/x/masao/bin/dot"
def dot_format (str, format = "png")
   ENV["LD_LIBRARY_PATH"] = "/usr/local/lib"
   ENV["DOTFONTPATH"] = "."
   cmd = open("|#{DOT} -T#{format} -Nfontname=kochi", "r+")
   cmd.print str
   cmd.close_write
   cmd.read
end

# TEST
if $0 == __FILE__
   test_dot = <<-EOF
digraph G {
  1 -> 2 -> 3
}
   EOF
   dotted_dot = <<-EOF
digraph G {
	node [fontname=kochi, label="\\N"];
	graph [bb="0,0,54,196"];
	1 [pos="27,170", width="0.75", height="0.50"];
	2 [pos="27,98", width="0.75", height="0.50"];
	3 [pos="27,26", width="0.75", height="0.50"];
	1 -> 2 [pos="e,27,116 27,152 27,144 27,135 27,126"];
	2 -> 3 [pos="e,27,44 27,80 27,72 27,63 27,54"];
}
   EOF
   # p dot_format(test_dot, "dot")
   # p dotted_dot
   p(dot_format(test_dot, "dot") == dotted_dot)
   
end

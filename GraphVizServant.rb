require 'GraphViz.rb'
require 'base64'
require 'graph/graphviz_dot'

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
     linklist = []
     namelist = {}
     STDERR.puts wordlist.class
     wordlist.each do |word|
	namelist[word.id] = word.name
	word.child.each do |child|
	   linklist << [ word.id, child.idref ]
	   namelist[child.idref] = child.name
	end
	word.parent.each do |parent|
	   linklist << [ parent.idref, word.id ]
	   namelist[parent.idref] = parent.name
	end
     end
     dgp = DotGraphPrinter.new(linklist)
     dgp.node_labeler = proc{|n| namelist[n]}
     return encode64(dgp.to_dot_specification)
  end
  
end

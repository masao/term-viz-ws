# class WordArray
class Array
   def to_dot (rankdir = "TB", baseurl = nil)
      retstr = "digraph G {\n"
      retstr << "  graph [rankdir=\"#{rankdir}\"];\n" if rankdir
      self.each do |word|
	 retstr << "  #{word.id} [label=\"#{word.name}\"];\n"
	 retstr << "  #{word.id} [URL=\"#{baseurl.gsub('#{id}', word.id)}\"];\n" if baseurl
	 word.child.each do |node|
	    retstr << "  #{node.idref} [label=\"#{node.name}\"];\n"
	    retstr << "  #{node.idref} [URL=\"#{baseurl.gsub('#{id}', node.idref)}\"];\n" if baseurl
	    retstr << "  #{word.id} -> #{node.idref};\n"
	 end
	 word.parent.each do |node|
	    retstr << "  #{node.idref} [label=\"#{node.name}\"];\n"
	    retstr << "  #{node.idref} [URL=\"#{baseurl.gsub('#{id}', node.idref)}\"];\n" if baseurl
	    retstr << "  #{node.idref} -> #{word.id};\n"
        end
      end
      retstr << "}\n"
   end
end

# class WordArray
class Array
   def to_dot (rankdir = "TB")
      retstr = "digraph G {\n"
      retstr << "  graph [rankdir=\"#{rankdir}\"];\n" if rankdir
      self.each do |word|
	 retstr << "  #{word.id} [label=\"#{word.name}\"];\n"
	 word.child.each do |node|
	    retstr << "  #{node.idref} [label=\"#{node.name}\"];\n"
	    retstr << "  #{word.id} -> #{node.idref};\n"
	 end
	 word.parent.each do |node|
	    retstr << "  #{node.idref} [label=\"#{node.name}\"];\n"
	    retstr << "  #{node.idref} -> #{word.id};\n"
        end
      end
      retstr << "}\n"
   end
end

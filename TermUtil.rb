require 'cgi'

def replace_url (str, param)
   str.gsub(/\$(\w+)/) do
      if param.has_key? $1
	 CGI::escape(param[$1])
      else
	 ""
      end
   end
end

# class WordArray
class Array
   def to_dot (rankdir = "TB", baseurl = nil)
      retstr = "digraph G {\n"
      retstr << "  graph [rankdir=\"#{rankdir}\"];\n" if rankdir
      self.each do |word|
	 param = { "label" => word.name, "id" => word.id }
	 retstr << "  #{word.id} [label=\"#{word.name}\"];\n"
	 retstr << "  #{word.id} [URL=\"#{ replace_url(baseurl, param) }\"];\n" if baseurl
	 word.child.each do |node|
	    param = { "label" => node.name, "id" => node.idref }
	    retstr << "  #{node.idref} [label=\"#{node.name}\"];\n"
	    retstr << "  #{node.idref} [URL=\"#{ replace_url(baseurl, param) }\"];\n" if baseurl
	    retstr << "  #{word.id} -> #{node.idref};\n"
	 end
	 word.parent.each do |node|
	    param = { "label" => node.name, "id" => node.idref }
	    retstr << "  #{node.idref} [label=\"#{node.name}\"];\n"
	    retstr << "  #{node.idref} [URL=\"#{ replace_url(baseurl, param) }\"];\n" if baseurl
	    retstr << "  #{node.idref} -> #{word.id};\n"
        end
      end
      retstr << "}\n"
   end
end

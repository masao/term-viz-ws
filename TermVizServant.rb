require 'TermViz.rb'
require 'sary'

class TermVizPort
   # SYNOPSIS
   #   doWordSearch( term )
   #
   # ARGS
   #   term		String - {http://www.w3.org/2001/XMLSchema}string
   #
   # RETURNS
   #   return		WordSearchResult - {urn:TermViz}WordSearchResult
   #
   # RAISES
   #    N/A
   #
   def doWordSearch( term )
      saryer = Sary::Saryer.new("edr_words")
      exact_match = []
      substr_match = []
      if saryer.icase_search(term)
	 saryer.each_context_line do |line|
	    if line =~ /^([^\t]+)\t(.*)$/
	       id = $1
	       word = $2
	       if word == term
		  exact_match.push(ResultElement.new(id, word))
	       else
		  substr_match.push(ResultElement.new(id, word))
	       end
	    end
	 end
      end
      WordSearchResult.new(exact_match, substr_match)
   end
   
   # SYNOPSIS
   #   getWordList( id )
   #
   # ARGS
   #   id		String - {http://www.w3.org/2001/XMLSchema}string
   #
   # RETURNS
   #   return		String - {http://www.w3.org/2001/XMLSchema}string
   #
   # RAISES
   #    N/A
   #
   def getWordList( id )
      raise NotImplementedError.new
   end
   
end


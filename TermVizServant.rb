require 'TermViz.rb'
require 'sary'
require 'bdb'

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
   #   return		WordList - {urn:TermViz}WordArray
   #
   # RAISES
   #    N/A
   #
   def getWordList( id )
      words = BDB::Hash.open("edr_words.db")
      raise "id not found: #{id}" unless words.has_key?(id)
      wordlist = WordArray.new
      children = NodeArray.new
      parents  = NodeArray.new

      c_db = BDB::Hash.open("edr_children.db")
      if c_db.has_key?(id)
	 c_db[id].split(/\|/).each do |c_id|
	    children.push(Node.new(words[c_id], c_id))
	 end
      end

      p_db  = BDB::Hash.open("edr_parents.db")
      if p_db.has_key?(id)
	 p_db[id].split(/\|/).each do |p_id|
	    parents.push(Node.new(words[p_id], p_id))
	 end
      end
      wordlist.push(Word.new(words[id], id, "", parents, children))
   end

end

require 'TermViz.rb'

class TermVizPort
  # SYNOPSIS
  #   doWordSearch( term )
  #
  # ARGS
  #   term		 - {http://www.w3.org/2001/XMLSchema}string
  #
  # RETURNS
  #   return		WordSearchResult - {urn:TermViz}WordSearchResult
  #
  # RAISES
  #    N/A
  #
  def doWordSearch( term )
    raise NotImplementedError.new
  end
  
  # SYNOPSIS
  #   getWordList( id )
  #
  # ARGS
  #   id		 - {http://www.w3.org/2001/XMLSchema}string
  #
  # RETURNS
  #   return		WordArray - {urn:TermViz}WordArray
  #
  # RAISES
  #    N/A
  #
  def getWordList( id )
    raise NotImplementedError.new
  end
  
end


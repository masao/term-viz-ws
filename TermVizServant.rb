require 'TermViz.rb'

class TermVizPort
  # SYNOPSIS
  #   doWordSearch( term, target )
  #
  # ARGS
  #   term		String - {http://www.w3.org/2001/XMLSchema}string
  #   target		String - {http://www.w3.org/2001/XMLSchema}string
  #
  # RETURNS
  #   return		String - {http://www.w3.org/2001/XMLSchema}string
  #
  # RAISES
  #    N/A
  #
  def doWordSearch( term, target )
    raise NotImplementedError.new
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


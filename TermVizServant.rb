require 'TermViz.rb'

class TermVizPort
  # SYNOPSIS
  #   wordSearch( term, target )
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
  def wordSearch( term, target )
     # raise NotImplementedError.new
     "Hello!!!"
  end
  
  # SYNOPSIS
  #   idSearch( id )
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
  def idSearch( id )
    raise NotImplementedError.new
  end
  
end


# urn:TermViz
class WordSearchResult
  def exactMatchElements
    @exactMatchElements
  end

  def exactMatchElements=( newexactMatchElements )
    @exactMatchElements = newexactMatchElements
  end

  def substrMatchElements
    @substrMatchElements
  end

  def substrMatchElements=( newsubstrMatchElements )
    @substrMatchElements = newsubstrMatchElements
  end


  def initialize( exactMatchElements = nil,
      substrMatchElements = nil )
    @exactMatchElements = exactMatchElements
    @substrMatchElements = substrMatchElements
  end
end

# urn:TermViz
class ResultElementArray < Array; end

# urn:TermViz
class ResultElement
  def id
    @id
  end

  def id=( newid )
    @id = newid
  end

  def word
    @word
  end

  def word=( newword )
    @word = newword
  end


  def initialize( id = nil,
      word = nil )
    @id = id
    @word = word
  end
end


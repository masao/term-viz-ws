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

# urn:TermViz
class WordArray < Array; end

# urn:TermViz
class Word
  def name
    @name
  end

  def name=( newname )
    @name = newname
  end

  def id
    @id
  end

  def id=( newid )
    @id = newid
  end

  def origin
    @origin
  end

  def origin=( neworigin )
    @origin = neworigin
  end

  def parent
    @parent
  end

  def parent=( newparent )
    @parent = newparent
  end

  def child
    @child
  end

  def child=( newchild )
    @child = newchild
  end


  def initialize( name = nil,
      id = nil,
      origin = nil,
      parent = nil,
      child = nil )
    @name = name
    @id = id
    @origin = origin
    @parent = parent
    @child = child
  end
end

# urn:TermViz
class NodeArray < Array; end

# urn:TermViz
class Node
  def word
    @word
  end

  def word=( newword )
    @word = newword
  end

  def idref
    @idref
  end

  def idref=( newidref )
    @idref = newidref
  end


  def initialize( word = nil,
      idref = nil )
    @word = word
    @idref = idref
  end
end


# urn:GraphViz
class WordArray < Array; end

# urn:GraphViz
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

# urn:GraphViz
class NodeArray < Array; end

# urn:GraphViz
class Node
  def name
    @name
  end

  def name=( newname )
    @name = newname
  end

  def idref
    @idref
  end

  def idref=( newidref )
    @idref = newidref
  end

  def initialize( name = nil,
      idref = nil )
    @name = name
    @idref = idref
  end
end


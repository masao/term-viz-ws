# urn:Term
class WordSearchResult
  @@typeName = "WordSearchResult"
  @@typeNamespace = "urn:Term"

  def exactMatchElements
    @exactMatchElements
  end

  def exactMatchElements=(new_exactMatchElements)
    @exactMatchElements = new_exactMatchElements
  end

  def substrMatchElements
    @substrMatchElements
  end

  def substrMatchElements=(new_substrMatchElements)
    @substrMatchElements = new_substrMatchElements
  end

  def initialize(exactMatchElements = nil,
      substrMatchElements = nil)
    @exactMatchElements = exactMatchElements
    @substrMatchElements = substrMatchElements
  end
end

# urn:Term
class NodeArray < Array
  @@typeName = "NodeArray"
  @@typeNamespace = "urn:Term"
end

# urn:Term
class Node
  @@typeName = "Node"
  @@typeNamespace = "urn:Term"

  def name
    @name
  end

  def name=(new_name)
    @name = new_name
  end

  def idref
    @idref
  end

  def idref=(new_idref)
    @idref = new_idref
  end

  def initialize(name = nil,
      idref = nil)
    @name = name
    @idref = idref
  end
end

# urn:Term
class WordArray < Array
  @@typeName = "WordArray"
  @@typeNamespace = "urn:Term"
end

# urn:Term
class Word
  @@typeName = "Word"
  @@typeNamespace = "urn:Term"

  def name
    @name
  end

  def name=(new_name)
    @name = new_name
  end

  def id
    @id
  end

  def id=(new_id)
    @id = new_id
  end

  def origin
    @origin
  end

  def origin=(new_origin)
    @origin = new_origin
  end

  def parent
    @parent
  end

  def parent=(new_parent)
    @parent = new_parent
  end

  def child
    @child
  end

  def child=(new_child)
    @child = new_child
  end

  def initialize(name = nil,
      id = nil,
      origin = nil,
      parent = nil,
      child = nil)
    @name = name
    @id = id
    @origin = origin
    @parent = parent
    @child = child
  end
end


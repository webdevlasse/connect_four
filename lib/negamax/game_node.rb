class GameNode

  class<<self; attr_accessor :node_values; end
  @node_values = {}

  def value
    if GameNode.node_values.has_key?(self)
      return GameNode.node_values[self] #Return already saved value
    end

    if self.leaf_value != nil
      val = self.leaf_value
      GameNode.node_values[self] = self.leaf_value
      return val
    end

    val = self.get_moves.map { |move, node| node.value.invert }.max
    GameNode.node_values[self] = val
  end

  def load_values(values_hash)
    GameNode.node_values = values_hash
  end

  def values
    GameNode.node_values
  end

  def get_moves
    raise NotImplementedError
  end

  def leaf_value
    raise NotImplementedError
  end

  def eql?(other)
    raise NotImplementedError
  end

  def hash
    raise NotImplementedError
  end

end
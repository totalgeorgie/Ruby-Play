module Searchable
  
  def dfs(value)
    return self if self.value == value
    return nil if self.children.empty?
    
    self.children.each do |child_node|
      child_node_dfs = child_node.dfs(value)
      return child_node_dfs if child_node_dfs != nil
    end
    nil
  end
  
  def bfs(value)
    queue = [self]
    until queue.empty?
      first_node = queue.shift
      return first_node if first_node.value == value
      first_node.children.each { |child_node| queue.push(child_node) }
    end
  end
end

class PolyTreeNode
  attr_reader :value, :parent, :children
  include Searchable
  
  def initialize(value)
    @value, @parent, @children = value, nil, []
  end
  
  def parent=(parent_node)
    @parent.children.delete(self) unless @parent.nil?
    @parent = parent_node
    @parent.children << self unless @parent.nil?
  end
  
  def add_child(child_node)
    child_node.parent=(self)
  end
  
  def remove_child(child_node)
    child_node.parent=(nil)
  end  
  
  def trace_path_back
    return [self.value] if self.parent.nil?
    self.parent.trace_path_back << self.value
  end
end

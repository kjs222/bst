class BinarySearchTree
  def initialize
    @root = nil
  end

  attr_accessor :root

  def find_insertion_point(value, current_node=@root, depth=0)
    depth += 1
    if value > current_node.data.value && current_node.right_open? || value < current_node.data.value && current_node.left_open?
      return current_node, depth
    else
      if value > current_node.data.value
        return find_insertion_point(value, current_node.right, depth)
      else
        return find_insertion_point(value, current_node.left, depth)
      end
    end
  end

  def insert(node)
    if root.nil?
      @root = node
      return 0
    else
      parent, depth = find_insertion_point(node.data.value)
      if node.data.value < parent.data.value
        parent.left = node
      else
        parent.right = node
      end
      return depth
    end
  end


end

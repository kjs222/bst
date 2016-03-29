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

  def include?(value, current_node=@root)
    if value == current_node.data.value
      true
    else
      if value > current_node.data.value && current_node.right
         include?(value, current_node.right)
      elsif value < current_node.data.value && current_node.left
         include?(value, current_node.left)
      else
        false
      end
    end

  end

  def depth_of(value, current_node=@root, depth=0)
    if include?(value)
      if value == current_node.data.value
        return depth
      else
        depth += 1
        if value > current_node.data.value
           depth_of(value, current_node.right, depth)
        else
           depth_of(value, current_node.left, depth)
        end
      end
    else
      nil
    end
  end

  def min_or_max(direction, current_node=@root)
    #send allows the method passed in to be treated like a variable
    if !current_node.send("#{direction}")
      movie = current_node
      return {movie.data.name => movie.data.value}
    else
      min_or_max(direction, current_node.send("#{direction}"))
    end
  end

  def min
    direction = "left"
    min_or_max(direction)
  end

  def max
    direction = "right"
    min_or_max(direction)
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

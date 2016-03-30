require 'pry'
require_relative 'node'
require_relative 'movie'
class BinarySearchTree
  def initialize
    @root = nil
    @sorted = []
  end

  attr_accessor :root
  attr_accessor :sorted

  #returns the parent and the depth where it will be put (not parent's depth)
  #traverses down left/right side of trees/subtrees until it finds an open space
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



  def sort(current_node=@root)
    if !current_node.nil?
      sort(current_node.left)
      movie = current_node

      sorted.push({movie.data.name => movie.data.value})
      sort(current_node.right)
      return sorted
    else
      return
    end
  end

  def count(current_node=@root, counter=0)
    if !current_node.nil?
      counter = counter + count(current_node.left, counter) + count(current_node.right, counter)
      counter +=1
      return counter
    else
      return 0
    end
  end


  def health(depth, current_node=@root)
    health_array = []
    #can stay for all substrings
    @sorted = []
    total_sort = sort(current_node=@root)
    # #unique to each substring
    # @sorted = []
    # sub_sort = sort(current_node=@root)
    # @sorted = []
    #
    # current_node = root
    # return [current_node.data.value, sub_sort.length, sub_sort.length/total_sort.length.to_f*100]



    until depth_of(current_node.data.value) == depth || current_node.left.nil?
      current_node = current_node.left
      #binding.pry
    end
      @sorted = []
      sub_sort = sort(current_node)
      @sorted = []
      health_array.push [current_node.data.value, sub_sort.length, ((sub_sort.length/total_sort.length.to_f)*100).round(1)]
      return health_array



    #3
    #go right until depth_of(nodes value) == depth

    #right right right
    #right right left
    #right left right
    #right left left
    #left right right
    #left right left
    #left left right
    #left left left
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

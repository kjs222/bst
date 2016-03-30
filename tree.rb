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
      #review this again why the right hangs out here and doesnt need push
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

  def find_nodes_at_depth(depth, current_node=@root, depth_arr =[])
    if !current_node.nil? && depth_of(current_node.data.value) < depth
      find_nodes_at_depth(depth, current_node.left, depth_arr)
      depth_arr.push(current_node) if depth_of(current_node.data.value) == depth-1
      find_nodes_at_depth(depth, current_node.right, depth_arr)
    else
      return
    end
      return depth_arr
  end



  def health(depth)
    total_count = count(@root, counter=0)
    health_array = []
    nodes = find_nodes_at_depth(depth)
    nodes.each do |node|
      sub_tree_count = count(node)
      health_array.push([node.data.value, sub_tree_count, ((sub_tree_count/total_count.to_f)*100).round(1)])
    end
    return health_array
  end




end



  tree = BinarySearchTree.new
  root = Node.new(Movie.new(98, "Animals United"))
  movie1_node = Node.new(Movie.new(58, "Armageddon"))
  movie2_node = Node.new(Movie.new(36, "Bill & Ted's Bogus Journey"))
  movie3_node = Node.new(Movie.new(93, "Bill & Ted's Excellent Adventure"))
  movie4_node = Node.new(Movie.new(86, "Charlie's Angels"))
  movie5_node = Node.new(Movie.new(38, "Charlie's Country"))
  movie6_node = Node.new(Movie.new(69, "Collateral Damage"))
  tree.insert(root)
  tree.insert(movie1_node)
  tree.insert(movie2_node)
  tree.insert(movie3_node)
  tree.insert(movie4_node)
  tree.insert(movie5_node)
  tree.insert(movie6_node)

  #p tree.find_left_nodes_at_depth(0)
  p tree.health(3)

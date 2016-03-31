require_relative 'node'
require_relative 'movie'

class BinarySearchTree
  def initialize
    @root = nil
    @sorted = []
  end

  attr_accessor :root
  attr_accessor :sorted

  #returns parent node and insertion depth
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


  #send allows the method passed in to be treated like a variable
  def min_or_max(direction, current_node=@root)
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


  def find_nodes_at_depth(depth, current_node=@root, depth_arr =[])
    if !current_node.nil? && depth_of(current_node.data.value) <= depth
      find_nodes_at_depth(depth, current_node.left, depth_arr)
      depth_arr.push(current_node) if depth_of(current_node.data.value) == depth
      find_nodes_at_depth(depth, current_node.right, depth_arr)
    else
      return
    end
    return depth_arr
  end


  def health(depth)
    health_array = []
    tree_total_count = count(@root)
    nodes_at_depth = find_nodes_at_depth(depth)
    nodes_at_depth.each do |node|
      sub_tree_count = count(node)
      health_array.push([node.data.value, sub_tree_count, ((sub_tree_count/tree_total_count.to_f)*100).floor])
    end
    return health_array
  end


  def format_movie_input(movie_line)
    movie = movie_line.split(', ', 2)
    movie[0] =movie[0].to_i
    movie[1] = movie[1].chomp
    return movie
  end


  def load(file, current_node=@root, count=0)
    File.readlines(file).each do |line|
      movie = format_movie_input(line)
      if root.nil? || !include?(movie[0])
        insert(Node.new(Movie.new(movie[0], movie[1])))
        count += 1 #consider reduce
      else
        next
      end
    end
    return count
  end

  def leaves(current_node=@root, count=0)
    if !current_node.nil? && !current_node.leaf?
      count = count + leaves(current_node.left, count) + leaves(current_node.right, count)
    elsif current_node.nil?
      return 0
    else
      count +=1
      return count
    end
  end

  def height(depth=0)
    until find_nodes_at_depth(depth).empty?
      depth += 1
      find_nodes_at_depth(depth).empty?
    end
    depth
  end








end

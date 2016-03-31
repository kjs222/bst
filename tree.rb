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


  def sort(current_node=@root, sorted=[])
    if !current_node.nil?
      sort(current_node.left, sorted)
      movie = current_node
      sorted.push({movie.data.name => movie.data.value})
      sort(current_node.right, sorted)
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


  def find_node(value, current_node=@root)
    if current_node.nil?
      return
    else
      if value == current_node.data.value
        return current_node
      elsif value < current_node.data.value
        find_node(value, current_node.left)
      else
        find_node(value, current_node.right)
      end
    end
  end

  def find_parent_of_node(value, current_node=@root)
    if current_node.nil?
      return
    else
      if (!current_node.right.nil? && value == current_node.right.data.value) || (!current_node.left.nil? && value == current_node.left.data.value)
        return current_node
      elsif !current_node.left.nil? && value < current_node.data.value
        find_parent_of_node(value, current_node.left)
      elsif !current_node.right.nil? && value > current_node.data.value
        find_parent_of_node(value, current_node.right)
      else
        return
      end
    end
  end

  def find_next_highest(value)
    sorted_tree = sort
    sorted_tree.each_with_index do |hash, index|
      if hash.values == [value]
        return sorted_tree[index+1].values.join.to_i
      end
    end
  end



  def delete(value)
    #need to handle root
    node_to_delete = find_node(value)
    node_to_delete_left = node_to_delete.left
    node_to_delete_right = node_to_delete.right
    parent = find_parent_of_node(value)

    if find_node(value).leaf?
      if value < parent.data.value
        parent.left = nil
      else
        parent.right = nil
      end

    elsif find_node(value).full?
      next_highest_value = find_next_highest(value)
      next_highest_node = find_node(next_highest_value)
      next_highest_parent = find_parent_of_node(next_highest_value)
      next_highest_left = next_highest_node.left
      next_highest_right = next_highest_node.right

      #set next highest as child of delete's parent
      if next_highest_value > parent.data.value
        parent.right = next_highest_node
      else
        parent.left = next_highest_node
      end
      #set delete's children as children of next highest
      next_highest_node.left = node_to_delete_left
      next_highest_node.right = node_to_delete_right

      #set next highest child as child of next highest parent
      next_highest_parent.left = next_highest_left
      next_highest_parent.right = next_highest_right

    else #1 child node to delete
      if node_to_delete.right
        child = node_to_delete.right
      else
        child = node_to_delete.left
      end
      if value < parent.data.value
        parent.left = child
      else
        parent.right = child
      end
    end

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

#p tree.sort
puts
puts "deleting 38"
tree.delete(38)
p tree.sort

puts
puts "deleting 86"
tree.delete(86)
p tree.sort

puts "deleting 98"
tree.delete(98)
p tree.sort

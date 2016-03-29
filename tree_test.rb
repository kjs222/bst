require 'minitest/autorun'
require 'minitest/pride'
require './tree'
require './node'
require './movie'

class TreeTest < MiniTest::Test
  def test_root_is_nil_at_instantiaion
    tree = BinarySearchTree.new
    assert_equal nil, tree.root
  end

  def test_insert_root_when_tree_empty
    tree = BinarySearchTree.new
    tree.insert(Node.new(Movie.new(10, "Goonies")))
    assert tree.root
    assert_equal 10, tree.root.data.value
  end

  def test_insertion_point_depth
    tree = BinarySearchTree.new
    root = Node.new(Movie.new(10, "Goonies"))
    tree.insert(root)
    insertion_node, depth = tree.find_insertion_point(15)
    assert_equal root, insertion_node
    assert_equal 1, depth
  end

  def test_insertion_correct_location
    tree = BinarySearchTree.new
    root = Node.new(Movie.new(10, "Goonies"))
    movie1_node = Node.new(Movie.new(5, "Shrek"))
    movie2_node = Node.new(Movie.new(15, "Test"))
    movie3_node = Node.new(Movie.new(7, "Test2"))
    tree.insert(root)
    tree.insert(movie1_node)
    tree.insert(movie2_node)
    tree.insert(movie3_node)
    assert_equal movie1_node, root.left
    assert_equal movie2_node, root.right
    assert_equal movie3_node, root.left.right
  end








end

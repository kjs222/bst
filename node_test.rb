require 'minitest/autorun'
require 'minitest/pride'
require './node'

class NodeTest < MiniTest::Test

  def test_left_is_nil_at_instantiation
    node = Node.new(Movie.new(10, "Goonies"))
    assert_equal nil, node.left
  end


  def test_right_is_nil_at_instantiation
    node = Node.new(Movie.new(10, "Goonies"))
    assert_equal nil, node.right
  end

  def test_node_has_data
    node = Node.new(Movie.new(10, "Goonies"))
    refute node.data.nil?
  end

  def test_node_data_is_movie_object
    node = Node.new(Movie.new(10, "Goonies"))
    assert_equal Movie, node.data.class
  end

  def test_node_data_is_accessible
    node = Node.new(Movie.new(10, "Goonies"))
    assert_equal "Goonies", node.data.name
    assert_equal 10, node.data.value
  end

  def test_leaf_is_a_leaf
    node = Node.new(Movie.new(10, "Goonies"))
    assert node.leaf?
    assert node.right_open?
    assert node.left_open?
    refute node.full?
  end

  def test_parent_is_not_a_leaf
    node = Node.new(Movie.new(10, "Goonies"))
    node.left = Node.new(Movie.new(5, "Shrek"))
    refute node.leaf?
    assert node.right_open?
    refute node.left_open?
    refute node.full?
    node.right = Node.new(Movie.new(15, "Deadpool"))
    refute node.leaf?
    refute node.right_open?
    refute node.left_open?
    assert node.full?
  end


end

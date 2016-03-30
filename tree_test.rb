require 'minitest/autorun'
require 'minitest/pride'
require './tree'
require './node'
require './movie'
require 'pry'

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

  def test_correct_insertion_point_for_first_after_root
    tree = BinarySearchTree.new
    root = Node.new(Movie.new(10, "Goonies"))
    tree.insert(root)
    insertion_node, depth = tree.find_insertion_point(15)
    assert_equal root, insertion_node
    assert_equal 1, depth
    insertion_node, depth = tree.find_insertion_point(5)
    assert_equal 1, depth
  end

  def test_insert_correct_location
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

    assert_equal movie1_node, root.left
    assert_equal movie2_node, root.left.left
    assert_equal movie3_node, root.left.right
    assert_equal movie4_node, root.left.right.left
    assert_equal movie5_node, root.left.left.right
    assert_equal movie6_node, root.left.right.left.left
  end

  def test_insert_returns_correct_depth
    tree = BinarySearchTree.new
    root = Node.new(Movie.new(98, "Animals United"))
    movie1_node = Node.new(Movie.new(58, "Armageddon"))
    movie2_node = Node.new(Movie.new(36, "Bill & Ted's Bogus Journey"))
    movie3_node = Node.new(Movie.new(93, "Bill & Ted's Excellent Adventure"))
    movie4_node = Node.new(Movie.new(86, "Charlie's Angels"))
    movie5_node = Node.new(Movie.new(38, "Charlie's Country"))
    movie6_node = Node.new(Movie.new(69, "Collateral Damage"))
    depth_root = tree.insert(root)
    depth1 = tree.insert(movie1_node)
    depth2 = tree.insert(movie2_node)
    depth3 = tree.insert(movie3_node)
    depth4 = tree.insert(movie4_node)
    depth5 = tree.insert(movie5_node)
    depth6 = tree.insert(movie6_node)
    assert_equal 0, depth_root
    assert_equal 1, depth1
    assert_equal 2, depth2
    assert_equal 2, depth3
    assert_equal 3, depth4
    assert_equal 3, depth5
    assert_equal 4, depth6

  end

  def test_it_knows_if_it_has_a_value
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

    assert tree.include?(98)
    assert tree.include?(58)
    assert tree.include?(36)
    assert tree.include?(93)
    assert tree.include?(86)
    assert tree.include?(38)
    assert tree.include?(69)
    refute tree.include?(200)
    refute tree.include?(17)
  end

  def test_it_knows_depth_of_a_value
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

    assert_equal 0, tree.depth_of(98)
    assert_equal 1, tree.depth_of(58)
    assert_equal 2, tree.depth_of(36)
    assert_equal 2, tree.depth_of(93)
    assert_equal 3, tree.depth_of(86)
    assert_equal 3, tree.depth_of(38)
    assert_equal 4, tree.depth_of(69)
    assert_equal nil, tree.depth_of(200)
    assert_equal nil, tree.depth_of(17)
  end

  def test_it_finds_min
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
    assert_equal ({"Armageddon"=>58}), tree.min

    tree.insert(movie3_node)
    tree.insert(movie4_node)
    assert_equal ({"Armageddon"=>58}), tree.min

    tree.insert(movie5_node)
    tree.insert(movie6_node)
    assert_equal ({"Charlie's Country"=>38}), tree.min

    tree.insert(movie2_node)
    assert_equal ({"Bill & Ted's Bogus Journey"=>36}), tree.min

  end

  def test_it_finds_max
    tree = BinarySearchTree.new
    root = Node.new(Movie.new(69, "Collateral Damage"))
    movie1_node = Node.new(Movie.new(58, "Armageddon"))
    movie2_node = Node.new(Movie.new(36, "Bill & Ted's Bogus Journey"))
    movie3_node = Node.new(Movie.new(93, "Bill & Ted's Excellent Adventure"))
    movie4_node = Node.new(Movie.new(86, "Charlie's Angels"))
    movie5_node = Node.new(Movie.new(38, "Charlie's Country"))
    movie6_node = Node.new(Movie.new(98, "Animals United"))

    tree.insert(root)
    tree.insert(movie1_node)
    assert_equal ({"Collateral Damage"=>69}), tree.max

    tree.insert(movie3_node)
    tree.insert(movie4_node)
    assert_equal ({"Bill & Ted's Excellent Adventure"=>93}), tree.max

    tree.insert(movie5_node)
    tree.insert(movie6_node)
    assert_equal ({"Animals United"=>98}), tree.max

    tree.insert(movie2_node)
    assert_equal ({"Animals United"=>98}), tree.max

  end

  def test_it_sorts_correctly

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

    expected_sort = [{"Bill & Ted's Bogus Journey"=>36}, {"Charlie's Country"=>38}, {"Armageddon"=>58}, {"Collateral Damage"=>69}, {"Charlie's Angels"=>86}, {"Bill & Ted's Excellent Adventure"=>93}, {"Animals United"=>98}]

    assert_equal expected_sort, tree.sort

  end


  def test_it_counts

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


    assert_equal 7, tree.count(root)
    assert_equal 6, tree.count(movie1_node)
    assert_equal 1, tree.count(movie5_node)

  end

  def test_it_finds_nodes_at_depth
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

    assert_equal 1, tree.find_nodes_at_depth(0).length
    assert_equal 1, tree.find_nodes_at_depth(1).length
    assert_equal 2, tree.find_nodes_at_depth(2).length
    assert_equal 2, tree.find_nodes_at_depth(3).length
    assert_equal 1, tree.find_nodes_at_depth(4).length
    assert_equal 0, tree.find_nodes_at_depth(5).length
    assert_equal [movie1_node], tree.find_nodes_at_depth(1)
    assert_equal [movie2_node, movie3_node], tree.find_nodes_at_depth(2)

  end

  def test_it_finds_health
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

    assert_equal 98, tree.health(0)[0][0]
    assert_equal 93, tree.health(2)[1][0]
    assert_equal 100.0, tree.health(0)[0][2]
    assert_equal 6, tree.health(1)[0][1]


  end










end

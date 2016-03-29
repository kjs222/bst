require 'minitest/autorun'
require 'minitest/pride'
require './movie'

class MovieTest < MiniTest::Test
  def test_it_has_readable_name
    goonies = Movie.new(10, "Goonies")
    name = goonies.name
    assert_equal "Goonies", name
  end

  def test_it_has_readable_value
    goonies = Movie.new(10, "Goonies")
    value = goonies.value
    assert_equal 10, value
  end

end

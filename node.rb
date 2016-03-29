require_relative 'movie'

class Node
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  attr_reader :data
  attr_accessor :left, :right

  def leaf?
    true if (left.nil? && right.nil?)
  end

  def right_open?
    true if right.nil?
  end

  def left_open?
    true if left.nil?
  end

  def full?
    true if !right_open? && !left_open?
  end

end

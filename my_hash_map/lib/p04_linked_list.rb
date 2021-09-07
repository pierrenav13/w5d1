class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    return @head if @tail.prev == @head
    @head.next
  end

  def last
    return @tail if @tail.prev == @head
    @tail.prev
  end

  def empty?
    return true if @tail.prev == @head
    false
  end

  def get(key)
    self.each do |node|
      return node.val if node.key == key
    end
  end

  def include?(key)
    self.each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.prev = @tail.prev
    new_node.prev.next = new_node
    new_node.next = @tail
    @tail.prev = new_node
    #self[-2].next = new_node
    nil
  end

  def update(key, val)
    find_node(key).val = val unless get(key) == nil
  end

  def remove(key)
    current_node = find_node(key)
    prev_node = current_node.prev
    next_node = current_node.next
    prev_node.next, next_node.prev = next_node, prev_node
  end

  def find_node(key)
    self.each do |node|
      return node if node.key == key
    end
  end

  def each
    i = @head.next
    until i.val == nil
      yield i
      j = i.next
      i = j
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end

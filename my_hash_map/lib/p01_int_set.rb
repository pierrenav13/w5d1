class MaxIntSet
  attr_reader :store
  def initialize(max)
    @max = max
    @store =  Array.new(max, false)
  end

  def insert(num)
    raise 'Out of bounds' if num > @max || num < 0
    @store[num] = true
    nil
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    return false unless @store[num] == true
    true
  end

  private
  

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    unless self[num].include?(num)
      i = num % @store.size
      @store[i] << num
    end
  end

  def remove(num)
    i = num % @store.size
    @store[i].delete(num)
  end

  def include?(num)
    return false unless self[num].include?(num)
    true
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    i = num % @store.size
    @store[i]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if count == @store.size
    unless include?(num)
      i = num % @store.size
      @store[i] << num
      @count += 1
    end
  end

  def remove(num)
    if include?(num)
      i = num % @store.size
      @store[i].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    i = num % @store.size
    @store[i].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    i = num % @store.size
    store[i]
  end

  def num_buckets
    @store.length
  end

  def resize!
    elements = @store.dup.flatten
    s = @store.size * 2
    @store = Array.new(s) {Array.new}
    @count = 0
    elements.each {|ele| insert(ele) }
    
  end
end

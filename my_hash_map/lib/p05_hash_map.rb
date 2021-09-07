require_relative 'p04_linked_list'

class HashMap
  attr_accessor :count
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    self.each do |k , v|
      return true if k == key
    end
    false
  end

  def set(key, val)
    resize! if count == num_buckets
    if include?(key)
      bucket(key).update(key, val)
    else
      bucket(key).append(key, val)
      @count += 1
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    bucket(key).remove(key)
    @count -= 1
  end

  def each
    @store.each do |list|
      list.each do |node|
        yield node.key, node.val
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    elements = []
    self.each { |k, v| elements << [k, v] }
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    @count = 0
    elements.each {|ele| set(ele[0], ele[1]) }
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    i = key.hash % num_buckets 
    @store[i]
  end
end

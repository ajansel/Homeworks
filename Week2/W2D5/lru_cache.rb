class LRUCache
  def initialize(size)
    @size = size
    @cache = []
  end

  def count
    # returns number of elements currently in cache
    @cache.length
    #Would make more sense to use @cache.count since the method is also called count
  end

  def add(el)
    # adds element to cache according to LRU principle
    if @cache.include?(el)
      @cache.delete(el)
      @cache.push(el)
    else
      @cache.push(el)
    end

    #Could have made this nested above
    @cache.shift if @cache.count > @size
  end

  def show
    # shows the items in the cache, with the LRU item first
    p @cache
  end

  private
  # helper methods go here!

end

#Use the following to test
#It should return 'true' because of line 44
#And then print the array on 57-58
johnny_cache = LRUCache.new(4)

johnny_cache.add("I walk the line")
johnny_cache.add(5)

p johnny_cache.count == 2

johnny_cache.add([1,2,3])
johnny_cache.add(5)
johnny_cache.add(-5)
johnny_cache.add({a: 1, b: 2, c: 3})
johnny_cache.add([1,2,3,4])
johnny_cache.add("I walk the line")
johnny_cache.add(:ring_of_fire)
johnny_cache.add("I walk the line")
johnny_cache.add({a: 1, b: 2, c: 3})

 johnny_cache.show
 # => prints [[1, 2, 3, 4], :ring_of_fire,
 # "I walk the line", {:a=>1, :b=>2, :c=>3}]

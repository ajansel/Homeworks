require 'byebug'

class Stack

  def initialize
    @stack = []
  end

  def add(el)
    @stack.push(el)
    #Do we have to use       @stack << el     what is the difference?
    el #How do we know we want to return the element?
  end

  def remove
    @stack.pop
  end

  def show
    @stack
    #Do we have to use .dup? What is the difference?
  end
end

class Queue

  def initialize
    @queue = []
  end

  def enqueue(el)
    @queue.push(el)
    el
  end

  def dequeue
    @queue.shift
  end

  def show
    @queue
  end
end

class Map

  def initialize
    @map = []
  end

  def assign(key,value)
    index = @map.index {|pair| pair[0] == key}

    if index == nil
      @map.push([key,value])
    else
      @map[index][1] = value
    end
    [key,value]
  end

  def remove(key)
    @map.reject! { |pair| pair[0] == key}
    nil #Do we really want to return nil everytime?
  end

  def lookup(key)
    @map.each {|pair| return pair[1] if pair[0] == key}
    nil
  end

  def show #Why would we need to implement a deep_dup here?
    @map
  end
end

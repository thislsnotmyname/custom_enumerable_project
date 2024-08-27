module Enumerable
  # Your code goes here
  def my_each_with_index
    return self unless block_given?
    index = 0
    self.my_each do |i|
      yield(i, index)
      index += 1
    end
  end
  def my_select
    copy = self.dup
    to_delete = []
    copy.my_each_with_index do |val, idx|
      to_delete << copy[idx] unless yield(val)
    end
    copy - to_delete
  end
  def my_all?
    self.my_each { |val| return false unless yield(val) }
    true
  end
  def my_any?
    self.my_each { |val| return true if yield(val) }
    false
  end
  def my_none?
    !self.my_any? { |val| yield(val) }
  end
  def my_count
    return self.length unless block_given?
    count = 0
    self.my_each { |val| count += 1 if yield(val) }
    count
  end
  def my_map
    copy = self.dup
    copy.my_each_with_index { |val, idx| copy[idx] = yield(val) }
  end
  def my_inject(accumulator = self[0])
    self.my_each { |val| accumulator = yield(val, accumulator) }
    accumulator
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    return self unless block_given?
    self.length.times do |index|
      yield(self[index])
    end
    self
  end
end

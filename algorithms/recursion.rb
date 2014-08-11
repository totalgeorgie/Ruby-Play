def range(a, b)
  if a == b
    [a]
  else
    range(a, b - 1) << b
  end
end

def recur_sum(arr)
  if arr.length == 1
    arr[0]
  else
    arr.pop + recur_sum(arr)
  end
end

def iter_sum(arr)
  sum = 0
  arr.each { |num| sum += num }
  sum
end

def exp1(b, pow)
  if pow == 0
    1
  else
    exp1(b, pow-1) * b
  end
end

def exp2(b, pow)
  if pow == 1
    b
  elsif pow.even?
    even_val = exp2(b, pow/2)
    even_val * even_val
  elsif pow.odd?
    odd_val = (exp2(b, (pow - 1) / 2))
    odd_val * odd_val * b
  end
end

class Array
  def deep_dup
    self.map do |element|
      if element.is_a?(Array)
        element.deep_dup
      else
        element
      end
    end
  end
end

def fib(n)
  return [] if n == 0
  return [0] if n == 1
  return [0, 1] if n == 2
  fib_array = fib(n-1)
  fib_array << fib_array[-2] + fib_array[-1]
end

def bsearch(arr, target)
  midpoint = arr.length/2
  mid = arr[midpoint]
  return midpoint if mid == target
  if target < mid
    bsearch(arr[0...midpoint], target) # left
  else
    bsearch(arr[midpoint+1..-1], target) + midpoint + 1 # right
  end  
end

































i = 0
until i > 250 && i % 7 == 0
  i += 1
end
print i

def factors number
  i = 1
  answer = []
  i.upto(number) do
    answer << i if number % i == 0
    i += 1
  end
  answer
end

def bubble_sort array
  sorted = false
  until sorted
    sorted = true
    (0...array.length-1).each do |i|
      if array[i] > array[i+1]
        array[i], array[i+1] = array[i+1], array[i]
        sorted = false
      end
    end
  end 
  
  array
end

def substrings(str)
  subs = []
  (0...str.length).each do |num1|
    (num1...str.length).each do |num2|
      subs << str[num1..num2] unless subs.include?(str[num1..num2])
    end
  end
  
  subs
end

def subwords string
  dictionary = File.readlines('dictionary.txt').map(&:chomp)
  substrings_to_filter = substrings(string)
  filtered_substrings = []
  substrings_to_filter.each do |substring|
    filtered_substrings << substring if dictionary.include?(substring)
  end
  filtered_substrings
end


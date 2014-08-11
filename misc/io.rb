def game
  comp_num = rand(1..100)
  user_num = nil
  until user_num == comp_num
    puts "Pick a number 1 to 100"
    user_num = gets.chomp.to_i
    puts "Number is too high" if user_num > comp_num
    puts "Number is too low" if user_num < comp_num
  end
  puts "You got the number! #{comp_num}"
end
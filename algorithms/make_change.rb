def make_change(amount, coins = [25, 10, 5, 1])
  puts "making #{amount} out of: #{coins}"
  result = []
  total = 0

  coin = coins[0]
  while total + coin <= amount
    total += coin
    result << coin
  end
  
  
  result_1 = (coins.length == 1 ? result : result + make_change(amount - total, coins[1..-1]))
  result_2 = (coins.length == 1 ? result : make_change(amount, coins[1..-1]))
  
  result_1.length < result_2.length ? result_1 : result_2 
  
  
  # result + make_change(amount - total, coins[1..-1])
  # possible_coins = coins.select { |coin| coin <= amount }.reverse #Keep only coins that are less than amount
  # possible_coins.each do |coin|
  #   grabs, left_over = amount.divmod(coin)
  # end

end

# [5, 5] + [1, 1, 1, 1] == [5, 5, 1, 1, 1, 1]

#first time through

#[10] + make_change(4, [7, 1])
# make_change(14, [7, 1])

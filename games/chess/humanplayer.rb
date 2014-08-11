class HumanPlayer
  def user_input
    begin
      puts "Please select position of piece to move; e.g: 1 2"
      start = gets.chomp.split(" ")
      start.map! { |coord| coord.to_i - 1}
      raise InvalidInputError.new("Invalid input") unless start.all? {|num| (0..7).include?(num)} &&  (start.length == 2)
    rescue InvalidInputError => e
      puts e.message
      retry
    end
    
    begin
      puts "Please select destination position; e.g: 2 2"
      end_pos = gets.chomp.split(" ")
      end_pos.map! { |coord| coord.to_i - 1 }
      raise InvalidInputError.new("Invalid input") unless end_pos.all? {|num| (0..7).include?(num)} &&  (end_pos.length == 2)
    rescue InvalidInputError => e
      puts e.message
      retry
    end
    
    [start, end_pos]
  end
end

class InvalidInputError < Exception
end
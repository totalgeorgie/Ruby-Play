require_relative 'board'

class Game
  def initialize
    @board = Board.new
  end
  
  def play
    turn_color = :black
    until @board.over?
      @board.display
      begin
        puts "Pick a piece to move, #{turn_color.to_s}!"
        input = get_user_input
        piece = @board.at(input.shift)
        raise InvalidInputError.new("Invalid input") if piece.nil? || piece.color != turn_color
        piece.perform_moves(input)
      rescue InvalidMoveError => e
        puts e.message
        retry
      rescue InvalidInputError => e
        puts e.message
        retry
      end
      turn_color == :black ? turn_color = :red : turn_color = :black
    end
    
    @board.won?(:black) ? puts("BLACK WINS") : puts("RED WINS")
  end
  
  def get_user_input
    begin
      user_input = []
      user_input << gets.chomp.chars.map! { |char| char.to_i }
      raise InvalidInputError.new("Invalid input") unless user_input[0].length == 2
    rescue InvalidInputError => e
      puts e.message
      retry
    end  

    puts "Add a tile to move to. Press enter to finish."
    loop do
      begin
        puts "Move Sequence: #{user_input}"
        moves = gets.chomp
        break if moves == ""
        raise InvalidInputError.new("Invalid input") unless moves.length == 2
        user_input << moves.chars.map! { |char| char.to_i }
      rescue InvalidInputError => e
        puts e.message
        retry
      end
    end
    
    user_input
  end
end

class InvalidInputError < StandardError
end

if $PROGRAM_NAME == __FILE__
  g = Game.new
  g.play
end

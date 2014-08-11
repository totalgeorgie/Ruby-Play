class Game
  attr_accessor :turn_count
  def initialize
    @turn_count = 0
    @guess_board = Array.new(10) {[]}
    @key_board = Array.new(10) {[]}
    @secret_code = Code.random
  end
  
  def play
    until @turn_count == 10 || won?
      guess = get_input
      @guess_board[@turn_count] = guess
      @key_board[@turn_count] = compare_codes guess, @secret_code
      display
      @turn_count += 1
    end
    puts "You won!"
  end
  
  def won?
    @key_board.include?( %w(b b b b) )
  end
  
  def get_input
    puts "Guess: "
    
    begin
      user_input = gets.chomp
      unless user_input.length == 4 && user_input.chars.all? {|letter| %w(r g b y o p).include?(letter)}
        raise "Incorrect color or length"
      end
    
    rescue
      puts "Please pick the colors again."
      retry
    end
    
    user_input.split("")
  end

  def display
    puts render
  end
  
  def render
    printable_board = "MASTERMIND\n"
    0.upto( @guess_board.length - 1 ) do |index|
      if @guess_board[index] == []
        printable_board << "\[____\] \| \[____\]\n"
      else
        printable_board << "#{@guess_board[index]} \| #{@key_board[index]} \n"
      end
    end
    printable_board
  end
  
  def compare_codes guess, answer
    response_code = []
    guess_test = guess.dup
    answer_test = answer.dup
    
    #checking for exact matches
    guess_test.each_index do |index|
      if guess_test[index] == answer_test[index]
        guess_test[index] = "exact_guess_test"
        answer_test[index] = "exact_answer_test"
        response_code << "b"
      end
    end
    
    #checking for near matches
    guess_test.each_with_index do |peg, index|
      if answer_test.include?(peg)
        answer_test[answer_test.index(peg)] = "near"
        response_code << "w"
      end
    end
    response_code
  end
  
end

class Code
  def self.random
    colors = %w(r g b y o p)
    random_array = []
    4.times do
      random_array << colors.sample
    end
    random_array
  end
end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.play
end
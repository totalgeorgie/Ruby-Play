class Board
  def initialize
    @board = Array.new(3) {
      Array.new(3) { " " }
    }
  end
  
  def won?
    won = false
    @board.each do |row|
      won = winning_row? row unless won
    end
    
    won = winning_column?( columns @board ) unless won
    
    won = winning_diagonal?( diagonals @board ) unless won
    
    won
  end
  
  def winning_row? row
    ( ( row[0] == row[1] ) && ( row[0] == row[2] ) ) && ( row[0] != " " )
  end
  
  def columns board
    columns = Array.new(3) { Array.new }
    board.each do |row|
      columns[0] << row[0]
      columns[1] << row[1]
      columns[2] << row[2]
    end
    columns
  end
  
  def winning_column? columns
    columns.each do |column|
      return true if winning_row? column
    end
    false
  end
  
  def diagonals board
    diagonals = Array.new(2) { Array.new }
    board.each_with_index do |row, index|
      diagonals[0] << row[index]
      diagonals[1] << row[-1 * index]
    end
    diagonals
  end
  
  def winning_diagonal? diagonals
    diagonals.each do |diagonal|
      return true if winning_row? diagonal
    end
    false
  end
  
  def winner
    move_count = 0
    @board.each do |row|
      row.each do |pos|
        move_count += 1 if pos !=  " "
      end
    end
    
    if move_count % 2 == 0
      "Player Two is the Tic-Tac-Toe champion!"
    else
      "Player One is the Tic-Tac-Toe champion!"
    end
  end
  
  def empty? pos
    @board[pos[0]][pos[1]] == " "
  end
  
  def place_mark pos, mark
     if empty? pos
       @board[pos[0]][pos[1]] = mark
     else
       false
     end
  end
  
  def render
    printable_board = "-------\n"
    @board.each do |row|
      printable_board += "\|"
      row.each do |pos|
        printable_board += "#{pos}\|"
      end
      printable_board += "\n-------\n"
    end
    printable_board
  end
end

class Game
  def initialize
    @board = Board.new
    @player_one = HumanPlayer.new "X", @board
    @player_two = ComputerPlayer.new "O", @board
    @turn = 1
  end
    
  def play
    until @board.won?
      if @turn > 9
        puts "This thrilling game of Tic-Tac-Toe has been fought to a draw!"
        break
      end
      
      puts "Turn: #{@turn}"
      
      if @turn % 2 == 1
        @player_one.move @player_one.get_input
      else
        @player_two.move @player_two.get_input
      end
      
      @turn += 1    
      puts @board.render
      puts "Has the game been won? #{@board.won?}"
    end
    
    puts @board.winner if @board.won?
  end
end

class HumanPlayer
  def initialize mark, board
    @mark = mark
    @board = board
  end
  
  def move pos
    @board.place_mark pos, @mark
  end
  
  def get_input
    row, column = 0, 0
    
    until valid_input? row
      puts "Choose row 1, 2, or 3, Player!"
      row = gets.chomp.to_i
    end
    
    until valid_input? column
      puts "Choose column 1, 2, or 3, Player!"
      column = gets.chomp.to_i
    end
    
    [row - 1, column - 1]
  end
  
  def valid_input? input
    [1, 2, 3].include?(input.to_i)
  end
end

class ComputerPlayer
  def initialize mark, board
    @mark = mark
    @board = board
  end
  
  def move input
    moved = false
    until moved
      row, column = input[0], input[1]
      if @board.empty? [row, column]
        @board.place_mark [row, column], @mark
        moved = true
      else
        input = get_input
      end
    end
  end
  
  def winning_move
    test_board = @board.dup
    test_board.place_mark [row, column], @mark
    
  end
  
  def get_input
    [rand(0..2), rand(0..2)]
  end
end
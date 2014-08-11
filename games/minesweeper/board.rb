class Board
  attr_accessor :board, :lost
  
  def initialize
    @board = Array.new(9) { Array.new(9) { Tile.new(self, nil) } }
    @lost = false
    seed_bombs
    set_positions
  end
  
  def display
    display_string = ""
    display_string << "  0  1  2  3  4  5  6  7  8\n"
    @board.each_with_index do |row, index|
      display_string << "#{index} "
      row.each do |tile|
        display_string << tile.tile_display
        display_string << "  "
      end
      display_string << "\n"
    end
    display_string
  end
  
  def test_display
    display_string = ""
    display_string << "  0  1  2  3  4  5  6  7  8\n"
    @board.each_with_index do |row, index|
      display_string << "#{index} "
      row.each do |tile|
        display_string << tile.tile_test_display
        display_string << "  "
      end
      display_string << "\n"
    end
    display_string
  end
  
  def seed_bombs
    number_bombs = 0
    until number_bombs == 10
      tile = @board.sample.sample
      unless tile.bomb
        tile.bomb = true
        number_bombs += 1
      end
    end
  end
  
  def set_positions
    (0...@board.length).each do |idx1|
      (0...@board[idx1].length).each do |idx2|
        @board[idx1][idx2].position = [idx1, idx2]
      end
    end
  end
  
  def mark(action, position)
    if action.downcase == 'r'
      @board[position[0]][position[1]].reveal!
    elsif action.downcase == 'f'
      @board[position[0]][position[1]].flag
    end
  end
  
  def won?
    if @lost
      return false
    else
      @board.all? do |row|
        row.all? do |tile|
          if tile.bomb && !tile.revealed?
            true
          else
            tile.revealed?
          end
        end
      end
    end
  end
end
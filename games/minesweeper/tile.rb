class Tile
  attr_accessor :bomb, :position, :revealed
  
  def initialize(board, position)
    @board = board
    @position = position
    @bomb, @revealed, @flagged = false, false, false
  end
  
  def revealed?
    @revealed
  end
  
  def neighbors
    tile_neighbor = []
    vectors = [-1, 0, 1]
    (0..vectors.length - 1).each do |idx1|
      (0..vectors.length - 1).each do |idx2|
        x_coord = @position[0] + vectors[idx1]
        y_coord = @position[1] + vectors[idx2]
        next unless (0..8).to_a.include?(x_coord)
        next unless (0..8).to_a.include?(y_coord)
        neighbor = @board.board[@position[0] + vectors[idx1]][@position[1] + vectors[idx2]]
        tile_neighbor << neighbor
      end
    end
    tile_neighbor
  end
  
  def bomb_count
    count = 0
    neighbors.each do |neighbor|
      if neighbor.bomb
        count += 1
      end
    end
    count
  end
  
  def reveal!
    if @flagged
      return false
    elsif @revealed
      return false
    elsif @bomb
      @revealed = true
      @board.lost = true
      return true
    else
      @revealed = true
      if bomb_count == 0
        neighbors.each do |neighbor|
          neighbor.reveal!
        end
      end
      return true
    end
  end
  
  def flag
    unless @revealed
      @flagged ? @flagged = false : @flagged = true
    end
  end
  
  def tile_display
    if @flagged
      return "F"
    elsif @revealed == false
      return "*"
    elsif @revealed && self.bomb_count == 0
      return "_"
    elsif @revealed && @bomb == false
      return "#{self.bomb_count}"
    else
      return "B"
    end
  end
  
  def tile_test_display
    if @bomb
      return "B"
    else
      return "#{self.bomb_count}"
    end
  end
end
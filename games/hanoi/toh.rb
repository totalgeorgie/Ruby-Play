class TowersOfHanoi
  attr_accessor :board
  def initialize
    @board = [ [3, 2, 1], [], [] ]
  end
  
  def move(from, to)
    raise "Empty peg!" if self.board[from].empty?
    if self.board[to].empty?
      disk = self.board[from].pop
      self.board[to].push(disk)
    else
      raise "Illegal move" if self.board[from].last > self.board[to].last
      disk = self.board[from].pop
      self.board[to].push(disk)
    end
  end
  
  def won?
    if self.board[0].empty?
      return self.board[1].sort.reverse == [3, 2, 1] ||
      self.board[2].sort.reverse == [3, 2, 1]
    end
    
    false
  end
  
  def play
    until won?
      start, end_pos = get_user_input
      move(start, end_pos)
    end
    return "you win"
  end
  
  def get_user_input
    puts "select a source and destination peg eg 0,2"
    gets.chomp.split(",").map(&:to_i)
  end
  
  def render
    self.board.to_s
  end
end

if $PROGRAM_NAME == __FILE__
  toh = TowersOfHanoi.new
  toh.play
end
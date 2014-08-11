# encoding: utf-8

class King < SteppingPiece
  def move_vectors
    [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, 1], [1, 0], [1, -1]]
  end
  
  def display
    return "♔" if @color == :white
    return "♚" if @color == :black
  end
end
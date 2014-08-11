# encoding: utf-8

class Knight < SteppingPiece
  def move_vectors
    [[-2, -1], [-1, -2], [-2, 1], [-1, 2], [1, 2], [1, -2], [2, 1], [2, -1]]
  end
  
  def display
    return "♘" if @color == :white
    return "♞" if @color == :black
  end
end
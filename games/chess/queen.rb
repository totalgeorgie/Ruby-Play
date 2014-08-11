# encoding: utf-8

class Queen < SlidingPiece
  def move_directions
    DIAG + ORTH
  end
  
  def display
    return "♕" if @color == :white
    return "♛" if @color == :black
  end
end
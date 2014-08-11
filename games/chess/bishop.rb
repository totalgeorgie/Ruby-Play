# encoding: utf-8

class Bishop < SlidingPiece
  def move_directions
    DIAG
  end
  
  def display
    return "♗" if @color == :white
    return "♝" if @color == :black
  end
end
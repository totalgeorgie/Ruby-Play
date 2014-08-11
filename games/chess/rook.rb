# encoding: utf-8

class Rook < SlidingPiece
  def move_directions
    ORTH
  end
  
  def display
    return "♖" if @color == :white
    return "♜" if @color == :black
  end
end
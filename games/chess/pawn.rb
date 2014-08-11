# encoding: utf-8

class Pawn < Piece
  
  def initialize(board, position, color)
    @board, @position, @color = board, position, color
  end
  
  def moves
    moves = []
    
    step_vectors.each do |vector|
      test_position = add_vector(@position, vector)
      if @board.open_pos?(test_position)
        moves << test_position
      end 
    end
    
    attack_vectors.each do |vector|
      test_position = add_vector(@position, vector)
      if @board.capturable_pos?(self.color, test_position)
        moves << test_position 
      end
    end
    
    moves
  end
  
  def step_vectors
    @color == :white ? [[-1, 0], [-2, 0]] : [[1, 0], [2, 0]]
  end
  
  def attack_vectors
    @color == :white ? [[-1, -1], [-1, 1]] : [[1, -1], [1, 1]]
  end
  
  def display
    return "♙" if @color == :white
    return "♟" if @color == :black
  end
end
# encoding: utf-8

class SlidingPiece < Piece
  ORTH = [[1,0], [-1, 0], [0 ,-1 ], [0, 1]]
  DIAG = [[1,1], [1, -1], [-1, 1], [-1, -1]]
  
  def moves
    moves = []

    move_directions.each do |vector|
      new_moves = follow_path(vector)
      moves += new_moves
    end
    
    moves
  end
  
  def follow_path(vector)
    test_position = add_vector(@position, vector)
    move_path = []
    
    while @board.open_pos?(test_position)
      move_path << test_position
      test_position = add_vector(test_position, vector)
    end

    move_path << test_position if @board.capturable_pos?(self.color, test_position)
    
    move_path
  end
end
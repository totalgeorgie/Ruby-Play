# encoding: utf-8

class SteppingPiece < Piece
  def moves
    moves = []
    
    move_vectors.each do |vector|
      test_position = add_vector(@position, vector)
      
      if @board.open_pos?(test_position) || @board.capturable_pos?(self.color, test_position)
        moves << test_position
      end
    end
    moves
  end
end
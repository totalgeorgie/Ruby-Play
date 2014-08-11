require './tic_tac_toe'

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos
  
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end
  
  def children
    next_moves = []
    board.rows.each_with_index do |row, y|
      row.each_with_index do |pos, x|
        if board.empty?([x, y])
          new_board = board.dup
          new_board[[x, y]] = @next_mover_mark
          next_next_mover_mark = ((@next_mover_mark == :x) ? :o : :x)
          new_node = TicTacToeNode.new(new_board, next_next_mover_mark, [x, y])
          next_moves << new_node
        end
      end
    end
    next_moves
  end
  
  # def losing_node?(mark)
#     #THIS IS A LOSING NODE IF THE GAME HAS BEEN WON BY THE OPPOSITE MARK
#     return true if @board.won? && @board.winner != mark
#     #IF THE NEXT MOVE IS OURS (AKA IT IS OUR TURN)
#     #IF ANY OF THE CHILDREN MOVES ARE WINNERS, THIS IS NOT A LOSING NODE
#     if (@next_mover_mark == mark)
#       self.children.each do |child_node|
#         return false unless child_node.losing_node?(mark)
#       end
#     else
#     #IF THE NEXT MOVE IS NOT OURS (AKA IT IS NOT OUR TURN)
#     #IF ANY OF THE CHILDREN MOVES ARE WINNERS
#       
#       return true if self.children.any? do |child|
#         child.board.winner != mark
#       end
#     end
#     false
#   end
  
  # def winning_node?(mark)
  #   return true if @board.won? && @board.winner != mark
  #   if (@next_mover_mark == mark)
  # 
  #     return true if self.children.any? do |child|
  #       child.board.winner == mark
  #     end
  #     
  #   else  
  #     self.children.each do |child_node|
  #       return false unless child_node.winning_node?(mark)
  #     end
  #   end
  #   false
  # end
  
  def losing_node?(mark)
    return board.winner != mark if board.won?
    return false if self.children.empty?
    if self.next_mover_mark == mark
      return true if self.children.all? do |child_node|
        child_node.losing_node?(mark)
      end
    else
      return true if self.children.any? do |child_node|
        child_node.losing_node?(mark)
      end
    end
    false
  end
  
  def winning_node?(mark)
    return @board.winner == mark if @board.won?
    return false if self.children.empty?
    
    if self.next_mover_mark == mark
      return true if self.children.all? do |child_node|
        child_node.winning_node?(mark)
      end
    else
      return true if self.children.any? do |child_node|
        child_node.winning_node?(mark)
      end
    end
    false  
  end
end
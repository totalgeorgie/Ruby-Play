# encoding: UTF-8

class Piece
  attr_accessor :board, :color, :pos, :promoted

	def initialize(board, color, pos, promoted)
    @board, @color, @pos, @promoted = board, color, pos, promoted
	end
  
  def perform_slide(pos)
    return false unless slide_moves.include?(pos)
    y, x = @pos
    y2, x2 = pos
    @board.grid[y2][x2] = self
    @pos = pos
    @board.grid[y][x] = nil
    maybe_promote
    true
  end
  
  def perform_jump(pos)
    return false unless jump_moves.include?(pos)
    orig_y, orig_x = @pos
    slide_y, slide_x = find_slide(@pos, pos)
    dest_y, dest_x = pos
    
    @board.grid[dest_y][dest_x] = self
    @board.grid[orig_y][orig_x] = nil
    @board.grid[slide_y][slide_x] = nil
    @pos = pos
    maybe_promote
    true
  end
  
  def perform_moves(move_seq)
    if valid_move_seq?(move_seq)
      perform_moves!(move_seq)
    else
      raise InvalidMoveError.new("Invalid move.")
    end
  end
  
  def perform_moves!(move_seq)
    if move_seq.length == 1
      return if perform_slide(move_seq.first)
      raise InvalidMoveError.new("Invalid move.") unless perform_jump(move_seq.first)
    else
      move_seq.each do |move|
        raise InvalidMoveError.new("Invalid move.") unless perform_jump(move)
      end
    end
  end
  
  def valid_move_seq?(move_seq)
    dup_board = @board.dup
    begin
      dup_board.at(@pos).perform_moves!(move_seq)
    rescue InvalidMoveError
      return false
    else
      return true
    end
  end
  
  def maybe_promote
    unless @promoted
      case @pos[0]
        when 0
          @promoted = true if self.color == :black
        when 7
          @promoted = true if self.color == :red
      end
    end
  end
  
  def pawn?
    !@promoted
  end
  
  def display
    @promoted ? "⛃" : "⛂"
  end
  
  private
  
  def slide_moves
    move_diffs.each_with_object([]) do |diff, moves|
      slide = add_diff(@pos, diff)
      if board.in_bounds?(slide)
        moves << slide unless @board.occupied?(@board.at(slide))
      end
    end
  end
  
  def jump_moves
    move_diffs.each_with_object([]) do |diff, moves|
      slide = add_diff(@pos, diff)
      jump = add_diff(slide, diff)
      if board.in_bounds?(jump)
        unless @board.occupied?(@board.at(jump))
          if @board.occupied?(@board.at(slide))
            if @board.at(slide).color != @color
              moves << jump
            end
          end
        end
      end
    end
  end
  
  def move_diffs
    return [[1, 1], [1, -1], [-1, 1], [-1, -1]] if @promoted
    @color == :red ? [[1, 1], [1, -1]] : [[-1, 1], [-1, -1]]
  end
  
  def add_diff(orig, diff)
    y, x = orig
    y2, x2 = diff
    [(y + y2), (x + x2)]
  end
  
  def find_slide(orig, dest)
    y, x = orig
    y2, x2 = dest
    [((y + y2) / 2), ((x + x2) / 2)]
  end
  
  def inspect
    "#{@color} #{@pos} #{@promoted}"
  end
end

class InvalidMoveError < StandardError
end

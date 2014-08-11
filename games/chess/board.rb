require 'colorize'
require_relative 'piece'

class Board
  attr_accessor :grid
  def initialize
    @grid = Array.new(8) { Array.new(8) { nil } }
    place_pieces
  end
  
  def dup
    dup_board = self.class.new
    dup_grid = []
    @grid.each do |row|
      dup_row = []
      row.each do |tile|
        if tile.nil?
          dup_row << nil
        else
          dup_row << Piece.new(
            dup_board, tile.color, tile.pos.dup, tile.promoted
          )
        end
      end
      dup_grid << dup_row
    end
    dup_board.grid = dup_grid
    dup_board
  end
  
  def display
    disp_str = "\n  0 1 2 3 4 5 6 7\n"
    @grid.each_with_index do |row, idx|
      disp_str << "#{idx} "
      row.each_with_index do |tile, idx2|
      (idx.even?) ? alternator = idx2.even? : alternator = idx2.odd?
        if alternator
          bg_color = :light_white 
        else
          bg_color = :light_black
        end
        if tile.nil?
          disp_str << "  ".colorize(:background => bg_color)
        else
          disp_str << "#{tile.display} ".colorize(:background => bg_color, :color => tile.color)
        end
      end
      disp_str << "\n"
    end
    puts disp_str
  end
  
  def at(pos)
    y, x = pos
    @grid[y][x]
  end
  
  def in_bounds?(pos)
    pos.all? { |coord| (0..7).include?(coord) }
  end
  
  def occupied?(tile)
    !tile.nil?
  end
  
  def all_pieces
    @grid.flatten.compact
  end
    
  def over?
    pieces(:black).count == 0 || pieces(:red).count == 0
  end
  
  def won?(color)
    color == :red ? pieces(:black).count == 0 : pieces(:red).count == 0
  end
  
  private
  
  def pieces(color)
    all_pieces.select{ |piece| piece.color == color }
  end
  
  def place_pieces
    @grid.map!.with_index do |row, idx|
      row.map!.with_index do |tile, idx2|
        if idx < 3
          if idx.odd? == idx2.odd?
            tile = Piece.new(self, :red, [idx, idx2], false)
          end
        elsif idx > 4
          if idx.odd? == idx2.odd?
            tile = Piece.new(self, :black, [idx, idx2], false)
          end
        end
      end
    end
  end
end

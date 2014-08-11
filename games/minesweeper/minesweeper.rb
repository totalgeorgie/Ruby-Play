require 'yaml'
require './board'
require './tile'

class Game
  def initialize
    @board = Board.new
    @elapsed_time = 0
  end
  
  def play
    @start_time = Time.now
    until @board.won? || @board.lost
      puts "#{@board.display}\n"
      user_input = get_user_input
      @board.mark(user_input[0], user_input[1]) if user_input.is_a?(Array)
    end
    
    @elapsed_time += Time.now - @start_time
    if @board.won?
      puts "You won this game of Minesweeper in #{@elapsed_time} seconds."
      set_scores
    else
      puts "#{@board.test_display}"
      puts "You lost this game of Minesweeper in #{@elapsed_time} seconds."
    end
  end
  
  def get_user_input
    puts "Type \'r\' or \'f\' to reveal or flag, then the coordinates of the tile.\n e.g: r,0,2"
    inputs = gets.chomp
    if inputs.downcase == 's'
      self.save
    elsif inputs.downcase == 'l'
      self.load
    else
      inputs = inputs.split(",")
      inputs[1] = [inputs[1].to_i, inputs[2].to_i]
      inputs.take(2)
    end
  end
  
  def save
    @elapsed_time += Time.now - @start_time
    print "File name: "
    file_name = gets.chomp
    file_name << ".minesweeper" unless file_name.match(".minesweeper")
    save_file = File.open("#{file_name}", "w")
    save_file.puts(self.to_yaml)
    save_file.close
  end
  
  def find_saved_files
    entries = Dir.entries(Dir.pwd)
    entries.select { |entry| entry.match(".minesweeper") }
  end
  
  def load
    puts "Files available: #{find_saved_files.join(", ")}"
    print "File name: "
    file_name = gets.chomp
    file_name << ".minesweeper" unless file_name.match(".minesweeper")
    loaded_game = YAML.load(File.open("#{file_name}", "r"))
    loaded_game.play
  end
  
  def set_scores
    high_scores = File.readlines("high_scores.txt") # [[name, best_time], etc.]
    output = []
    (0..high_scores.length - 2).each do |idx|
      next if idx.odd?
      output << [high_scores[idx], high_scores[idx + 1]]
    end
    
    print "Enter your name: "
    name = gets.chomp
    output << ["#{name}", @elapsed_time]
    times = []
    output.each { |record| times << record[1] }
    times = times.sort!.take(5)
    output = output.select { |record| times.include?(record[1]) }
    File.open("high_scores.txt", "w") do |file|
      file.puts(output)
      file.close
    end
  end
end

if $PROGRAM_NAME == __FILE__
  g = Game.new
  g.play
end
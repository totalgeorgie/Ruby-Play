require_relative 'computer_player'
require_relative 'human_player'

class Hangman
  attr_accessor :dictionary, :secret_word, :dead_letters, :guessed_letters
  def initialize guessing_player, checking_player
    @secret_word = checking_player.choose_word
    @guessed_letters = []
    @dead_letters = 0
    @guessing_player = guessing_player
    @checking_player = checking_player
    @guessing_player.receive_secret_length(@secret_word)
  end
  
  def play
    
    until won? || dead?
      display
      last_guessed_letter = @guessing_player.give_input
      puts "The guess: #{last_guessed_letter}"
      @guessed_letters << last_guessed_letter
      indices = @checking_player.check_guess(last_guessed_letter)
      if indices == []
        @dead_letters += 1
      else
        indices.each do |i|
          @secret_word[i] = last_guessed_letter
        end
      end
      @guessing_player.handle_guess_response(last_guessed_letter, indices)
    end
    
    if won?
      puts "HOORAY! The word was: #{@secret_word.join}."
    elsif dead?
      puts "He's dead, Jim."
    end
  end
  
  def won?
    @secret_word.count('-') == 0 
  end
  
  def dead?
    @dead_letters > 6
  end
  
  def display
    puts render
  end
  
  def render    
    "Secret word: #{@secret_word.join}\nI'm gonna die in #{7 - @dead_letters} guesses! Help!"
  end
  
end

if __FILE__ == $PROGRAM_NAME 
  game = Hangman.new(HumanPlayer.new, HumanPlayer.new)
  game.play
end
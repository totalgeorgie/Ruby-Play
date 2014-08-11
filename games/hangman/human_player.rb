require 'debugger'

class InvalidInputError < StandardError
end

class HumanPlayer
  def initialize
  end
  
  def choose_word
    begin
      puts "Word length?"
    
      input = Integer(gets.chomp)
    rescue => e
      puts e.message
      retry
    end
    
    word_length = ""
    input.times do
      word_length << "-"
    end
    word_length.split("")
  end
  
  def check_guess letter
    response = ""
    puts "Enter postions to place this letter. (E.g. 1 2 3)\nEnter q if there's no place to put it." 
    response = gets.chomp
    response == 'q' ? [] : response.split.map {|i| i.to_i - 1}
  end
  
  def give_input
    puts "Please guess a letter:"
    begin
      letter = gets.chomp
      unless ("a".."z").include?(letter)
        raise InvalidInputError.new("that's not a letter")
      end
    # rescue InvalidInputError => e
    #   # debugger
    #   puts e
    #   retry
    end
  end
  
  def receive_secret_length word
  end
  
  def handle_guess_response letter, indices
  end
end
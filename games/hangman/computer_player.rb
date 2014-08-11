

class ComputerPlayer
  def initialize
    @dictionary = File.readlines("dictionary.txt").map(&:chomp)
    @guessed_letters = []
  end
  
  def choose_word
    @secret = @dictionary.sample
    @secret.split('').map{'-'}
  end
  
  def check_guess letter
    indices = []
    @secret.split('').each_with_index do |char, index|
      if letter == char
        indices << index
      end
    end
    indices
  end
  
  def give_input
    most_frequent_letter = find_most_frequent_letter
    @guessed_letters << most_frequent_letter
    most_frequent_letter
  end
  
  def handle_guess_response letter, indices
    if indices == []
      remove_words_with_wrong_letter(letter)
    else
      remove_wrong_words(letter, indices)
    end
  end
  
  def receive_secret_length word
    @secret_length = word.length
    remove_long_words
  end
  
  def remove_long_words
    @dictionary = @dictionary.select do |word|
      word.length == @secret_length
    end
  end
  
  def remove_wrong_words letter, indices
    @dictionary = @dictionary.select do |word|
      indices.all? { |i| word[i] == letter }
    end
  end
  
  
  def remove_words_with_wrong_letter wrong_letter
    @dictionary = @dictionary.select do |word|
      !word.include?(wrong_letter)
    end
  end
  
  def find_most_frequent_letter
    word_counts = []
    alphabet = ("a".."z").to_a
    alphabet.each do |letter|
      letter_count = 0
      @dictionary.each do |word|
        letter_count += word.count(letter) unless @guessed_letters.include?(letter)
      end
      word_counts << letter_count
    end
    alphabet[word_counts.index(word_counts.max)]
  end 
end
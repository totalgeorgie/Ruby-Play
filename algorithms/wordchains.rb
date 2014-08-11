require 'set'
class WordChainer
  def initialize(dictionary_file_name)
    @dictionary = Set.new(File.readlines(dictionary_file_name).collect { |line| line.chomp })
  end
  
  def adjacent_words(word)
    adjacent_words = []
    word.length.times do |index|
      ("a".."z").each do |letter|
        modified_word = word.dup
        modified_word[index] = letter
        adjacent_words << modified_word if @dictionary.include?(modified_word) && !adjacent_words.include?(modified_word) && modified_word != word
      end
    end
    adjacent_words
  end
  
  def run(source, target)
    @current_words = [source]
    @all_seen_words = { source => nil }
    until @current_words.empty?
      explore_current_words(@current_words)
      break if @all_seen_words.include?(target)
    end
    build_path(target).reverse
  end
  
  def explore_current_words(current_words)
    new_current_words = []
    current_words.each do |current_word|
      adjacent_words(current_word).each do |adjacent_word|
       unless @all_seen_words.include?(adjacent_word)
         @all_seen_words[adjacent_word] = current_word
         new_current_words << adjacent_word
       end
      end
    end
    @current_words = new_current_words
  end
  
  def build_path(target)
    path = [target]
    until @all_seen_words[target].nil?
      path << @all_seen_words[target]
      target = @all_seen_words[target]
    end
    path
  end
end

if $PROGRAM_NAME == __FILE__
  wc = WordChainer.new('dictionary.txt')
  wc.run(ARGV[0], ARGV[1]).each do |word|
    puts word
  end
end
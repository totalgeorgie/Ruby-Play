require_relative 'card'

class Deck
  attr_accessor :deck
  def initialize
    @deck = []
    build_deck
  end
  
  def build_deck
    [:spade, :club, :heart, :diamond].each do |suit|
      (2..14).each do |value|
        self.deck << Card.new(suit, value)
      end
    end
  end
  
  def draw_card
    self.deck.pop
  end
  
  def receive_card(card)
    self.deck.unshift(card)
  end
  
  def count
    self.deck.count
  end
  
  def shuffle
    self.deck.shuffle!
  end
end
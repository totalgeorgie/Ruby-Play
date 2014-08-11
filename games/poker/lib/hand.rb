require_relative 'deck'

class Hand
  attr_accessor :hand
  def initialize
    @hand = []
  end
  
  # def value
  # end
  
  HAND_RANKS = [
    :straight_flush,
    :four_of_a_kind,
    :full_house,
    :three_of_a_kind,
    :flush,
    :straight,
    :two_pair,
    :one_pair,
    :high_card
  ]
  
  def beats?(other_hand)
    self.best_hand < other_hand.best_hand
  end
  
  def tie?(other_hand)
    self.best_hand == other_hand.best_hand    
  end
  
  def straight_flush?
    self.flush? && self.straight?
  end #kickers

  def four_of_a_kind?
    n_of_a_kind(4)
  end #high quadruple > kickers
  
  def full_house?
    n_of_a_kind(3) && n_of_a_kind(2)
  end #high triple > high pair

  def three_of_a_kind?
    n_of_a_kind(3)
  end #high triple > kickers
  
  def flush?
    self.hand.all? { |card| card.suit == self.hand.first.suit }
  end #kickers
  
  def straight?
    self.sort!
    self.hand.each_with_index do |card, idx|
      break if idx == 4
      return false unless card.value == (hand[idx + 1].value - 1)
    end
    true
  end #kickers
  
  def two_pair?
    self.n_pair(2)
  end #high pair > low pair > kickers
  
  def one_pair?
    self.n_pair(1)
  end #high pair > kickers
  
  def high_card?
    !(self.straight_flush? || self.four_of_a_kind? || self.three_of_a_kind? || 
    self.full_house? || self.two_pair? || self.one_pair? )
  end #kickers
  
  def sort!
    self.hand = self.hand.sort{ |card1, card2| card1.value <=> card2.value  }
  end
  
  def n_of_a_kind(n)
    self.sort!
    hand_values = self.get_card_values
    hand_values.count(self.hand.first.value) == n ||
    hand_values.count(self.hand.last.value) == n
  end
  
  def n_pair(n)
    card_values = self.get_card_values
    possible_pair_cards = card_values.select do |value| 
      card_values.count(value) == 2
    end
    possible_pair_cards.length == 2 * n
  end
  
  def get_card_values
    self.hand.map { |card| card.value }
  end
  
  def get_high_card
    self.get_card_values.max
  end
  
  def best_hand
    HAND_RANKS.each_index do |idx|
      return idx if self.send("#{HAND_RANKS[idx]}?")
    end
  end
end
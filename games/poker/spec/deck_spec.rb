require 'rspec'
require_relative '../lib/deck.rb'

describe Deck do
  let (:deck) { Deck.new }
  
  describe '#build_deck' do
    it 'should be a deck of 52 cards' do 
      expect(deck.count).to eq(52)
    end
  end
  
  describe '#draw_card' do
    it 'should remove a card from the top of the deck' do
      drawn_card = deck.draw_card
      expect(deck.deck.include?(drawn_card)).to be_false
    end
  end

  describe '#shuffle' do
    it 'should shuffle the deck' do
      deck2 = Deck.new
      deck.shuffle
      expect(deck.deck).to_not eq(deck2.deck)
    end
  end
  
  describe '#receive_card' do
    it 'should add a card to the bottom of the deck' do
      received_card = Card.new(:spade, 14)
      deck.receive_card(received_card)
      expect(deck.deck.first).to eq(received_card)
      expect(deck.count).to eq(53)
    end
  end
end
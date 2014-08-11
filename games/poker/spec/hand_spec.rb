require 'rspec'
require_relative '../lib/hand.rb'

describe Hand do
  let(:hand) { Hand.new }
  let(:royal_flush) { Hand.new }
  before(:each) do
    royal_flush.hand = [ 
      Card.new(:spade, 10),
      Card.new(:spade, 11),
      Card.new(:spade, 12),
      Card.new(:spade, 13),
      Card.new(:spade, 14)
    ]
    
    hand.hand = [ 
      Card.new(:spade, 2),
      Card.new(:heart, 11),
      Card.new(:diamond, 5),
      Card.new(:club, 10),
      Card.new(:spade, 14)
    ]
  end
  
  describe '#beats?' do
    it 'should return true if hand beats passed hand' do
      expect(royal_flush.beats?(hand)).to be_true
    end
    
    it 'should return false if hand does not beat passed hand' do
      expect(hand.beats?(royal_flush)).to be_false
    end
  end
  
  describe '#tie?' do
    it 'return true if hands are tied' do
      expect(royal_flush.tie?(royal_flush)).to be_true
    end
  end
  
  describe '#straight_flush?' do
    it 'should return true for a straight flush' do
      expect(royal_flush.straight_flush?).to be_true
    end
  end
  
  describe '#four_of_a_kind?' do
    it 'should return true for a four of a kind' do
      hand.hand = [
        Card.new(:spade, 10),
        Card.new(:heart, 10),
        Card.new(:club, 10),
        Card.new(:diamond, 10),
        Card.new(:spade, 14)
      ]
      expect(hand.four_of_a_kind?).to be_true
    end
  end
  
  describe '#full_house?' do
    it 'should return true for a full house' do
      hand.hand = [
        Card.new(:spade, 10),
        Card.new(:heart, 10),
        Card.new(:club, 10),
        Card.new(:diamond, 11),
        Card.new(:spade, 11)
      ]
      expect(hand.full_house?).to be_true      
    end
  end
  
  describe '#flush?' do
    it 'should return true for a flush' do
      hand.hand = [
        Card.new(:spade, 2),
        Card.new(:spade, 10),
        Card.new(:spade, 11),
        Card.new(:spade, 4),
        Card.new(:spade, 14)
      ]
      expect(hand.flush?).to be_true
    end
  end
  
  describe '#straight?' do
    it 'should return true for a straight' do
      hand.hand = [
        Card.new(:spade, 2),
        Card.new(:heart, 3),
        Card.new(:club, 4),
        Card.new(:diamond, 5),
        Card.new(:spade, 6)
      ]
      expect(hand.straight?).to be_true
    end
  end
  
  describe '#three_of_a_kind?' do
    it 'should return true for a three of a kind' do
      hand.hand = [
        Card.new(:spade, 10),
        Card.new(:heart, 10),
        Card.new(:club, 10),
        Card.new(:diamond, 13),
        Card.new(:spade, 11)
      ]
      expect(hand.three_of_a_kind?).to be_true
    end
  end
  
  describe '#two_pair?' do
    it 'should return true for a two pair' do
      hand.hand = [
        Card.new(:spade, 10),
        Card.new(:heart, 10),
        Card.new(:club, 9),
        Card.new(:diamond, 11),
        Card.new(:spade, 11)
      ]
      expect(hand.two_pair?).to be_true
    end
  end
  
  describe '#one_pair?' do
    it 'should return true for a one pair' do
      hand.hand = [
        Card.new(:spade, 7),
        Card.new(:heart, 10),
        Card.new(:club, 2),
        Card.new(:diamond, 11),
        Card.new(:spade, 11)
      ]
      expect(hand.one_pair?).to be_true
    end
  end
  
  describe '#high_card?' do
    it 'should return true for a high card' do
      hand.hand = [
        Card.new(:spade, 8),
        Card.new(:heart, 10),
        Card.new(:club, 4),
        Card.new(:diamond, 2),
        Card.new(:spade, 14)
      ]
      expect(hand.high_card?).to be_true
    end
  end
  
  describe '#sort!' do
    it 'should sort a hand from smallest value to greatest' do
      hand.hand = [
        Card.new(:spade, 8),
        Card.new(:heart, 10),
        Card.new(:club, 4),
        Card.new(:diamond, 2),
        Card.new(:spade, 14)
      ]
      sorted_hand = [
        Card.new(:diamond, 2),
        Card.new(:club, 4),
        Card.new(:spade, 8),
        Card.new(:heart, 10),
        Card.new(:spade, 14)
      ]
      hand.sort!
      hand_values = hand.hand.map { |card| card.value }
      sorted_values = sorted_hand.map { |card| card.value }
      expect(hand_values).to eq(sorted_values)
    end
  end
end

# describe '#take_card' do
#   it 'should not be able to draw if card count is 5' do
#     expect(hand.take_card).to raise_error(StandardError)
#   end
#   
#   it 'should take card from deck' do 
#     
#   end
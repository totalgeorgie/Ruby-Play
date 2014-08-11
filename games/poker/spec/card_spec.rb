require 'rspec'
require_relative '../lib/card.rb'

describe Card do
  let(:card) { Card.new(:spade, 14) }
  
  describe '#suit' do
    it 'should return the suit' do 
      expect(card.suit).to eq(:spade)
    end
  end
  
  describe '#value' do
    it 'should return the value' do 
      expect(card.value).to eq(14)
    end
  end
end
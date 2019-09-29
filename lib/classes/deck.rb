# frozen_string_literal: true

# :nodoc:
class Deck
  attr_accessor :suits, :ranks, :cards

  def initialize
    @cards = []
    build!
  end

  def shuffle!
    @cards.shuffle!
  end

  def draw!
    @cards.pop
  end

  private

  def build!
    Card::SUITS.each do |suit|
      Card::RANKS.each do |rank, value|
        @cards << Card.new(suit, rank, value)
      end
    end
  end
end

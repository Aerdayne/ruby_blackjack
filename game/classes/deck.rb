# frozen_string_literal: true

class Deck
  attr_accessor :suits, :ranks, :cards

  def initialize
    self.suits = %i[clubs diamonds hearts spades]
    self.ranks = { ace: 0, king: 10, queen: 10, jack: 10, ten: 10, nine: 9, eight: 8, seven: 7,
                   six: 6, five: 5, four: 4, three: 3, two: 2 }
    self.cards = []
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
    @suits.each do |suit|
      @ranks.each do |rank, value|
        @cards << Card.new(suit, rank, value)
      end
    end
  end
end

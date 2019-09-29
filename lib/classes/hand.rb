# frozen_string_literal: true

# :nodoc:
class Hand
  attr_accessor :cards, :total_value, :table

  def initialize(table)
    @table = table
    @cards = []
    @total_value = 0
    @flipped = false
  end

  def flipped?
    @flipped == true
  end

  def draw!
    @cards << table.deck.draw!
  end

  def flip
    @flipped = true
    [@cards, calculate_value!]
  end

  def reshuffle!
    @flipped = false
    @table.deck.cards << @cards.pop until @cards.empty?
  end

  def calculate_value!
    @total_value = 0
    @cards.reject(&:ace?).each do |card|
      @total_value += card.value
    end
    @cards.select(&:ace?).each do
      @total_value += @total_value + 11 > 21 ? 1 : 11
    end
    @total_value -= 10 if @cards.select(&:ace?).length > 1 && @total_value > 21
    @total_value
  end
end

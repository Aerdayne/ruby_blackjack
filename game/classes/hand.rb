# frozen_string_literal: true

class Hand
  attr_accessor :cards, :total_value, :table
  def initialize(table)
    self.table = table
    self.cards = []
    self.total_value = 0
  end

  def draw!
    @total_value = 0
    @cards << table.deck.draw!
  end

  def flip
    [@cards, calculate_value!]
  end

  def reshuffle!
    @table.deck.cards << @cards.pop until @cards.empty?
  end

  def calculate_value!
    @total_value = 0
    @cards.reject(&:ace?).each do |card|
      @total_value += card.value
    end
    @cards.select(&:ace?).each do
      @total_value += if @total_value + 11 > 21
                        1
                      else
                        11
                      end
    end
    @total_value
  end
end

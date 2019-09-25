# frozen_string_literal: true

# Card class
class Card
  attr_accessor :suit, :rank, :value

  def initialize(suit, rank, value)
    self.suit = suit
    self.rank = rank
    self.value = value
  end

  def ace?
    @rank == :ace
  end
end

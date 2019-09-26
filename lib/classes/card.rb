# frozen_string_literal: true

# :nodoc:
class Card
  attr_accessor :suit, :rank, :value

  def initialize(suit, rank, value)
    @suit = suit
    @rank = rank
    @value = value
  end

  def ace?
    @rank == :ace
  end
end

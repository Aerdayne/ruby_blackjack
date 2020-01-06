# frozen_string_literal: true

# Card logic class
#   @suit  - card suit
#   @rank  - card rank
#   @value - card value
class Card
  include Validation

  attr_accessor :suit, :rank, :value

  SUITS = %i[clubs diamonds hearts spades].freeze
  RANKS = { ace: 0, king: 10, queen: 10, jack: 10,
            ten: 10, nine: 9, eight: 8, seven: 7,
            six: 6, five: 5, four: 4, three: 3, two: 2 }.freeze

  validate :suit, :includes, SUITS
  validate :rank, :includes, RANKS

  def initialize(suit, rank, value)
    @suit = suit
    @rank = rank
    @value = value
    validate!
  end

  def ace?
    @rank == :ace
  end
end

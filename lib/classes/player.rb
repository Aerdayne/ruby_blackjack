# frozen_string_literal: true

# Actor (both player and dealer) logic class
#   @table - Table parent object
#   @hand  - Hand object
class Player
  attr_accessor :table, :hand

  def initialize(table)
    @table = table
    @hand = Hand.new(table)
  end

  def bet!
    @table.bank.accept_bet(self, 10)
  end

  def stand
    :stand
  end

  def hit!
    raise HandException if @hand.cards.length > 2

    @hand.draw!
    :hit
  end

  def flip
    @hand.flip
    :flip
  end
end

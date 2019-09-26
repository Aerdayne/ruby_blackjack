# frozen_string_literal: true

# :nodoc:
class Player
  attr_accessor :table, :hand, :bank, :actions

  def initialize(table)
    @table = table
    @hand = Hand.new(table)
    @bank = 100
  end

  def bet!
    raise BankException if @bank.zero?

    @bank -= 10
    @table.bank += 10
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

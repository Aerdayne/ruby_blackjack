# frozen_string_literal: true

class Player
  attr_accessor :table, :hand, :bank, :actions
  def initialize(table)
    self.table = table
    self.hand = Hand.new(table)
    self.bank = 100
  end

  def bet!
    raise BankException if (@bank -= 10).negative?

    @bank -= 10
    @table.bank += 10
  end

  def stand
    []
  end

  def hit!
    raise HandException if @hand.cards.length > 2

    @hand.draw!
  end

  def flip
    @hand.flip
  end
end

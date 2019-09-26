# frozen_string_literal: true

# :nodoc:
class Round
  attr_accessor :table, :turn, :result
  def initialize(table)
    @table = table
    @turn = nil
    @result = { player: [], dealer: [], winner: nil }
  end

  def start
    @table.deck.shuffle!
    [@table.player, @table.dealer].each do |actor|
      actor.bet!
      2.times { actor.hit! }
    end
  end

  def finish
    @result[:player] = @table.player.hand.flip.map(&:clone)
    @result[:dealer] = @table.dealer.hand.flip.map(&:clone)
    [@table.player, @table.dealer].each { |actor| actor.hand.reshuffle! }
    @result
  end

  def next_turn(actor_turn)
    @turn = actor_turn.new(self)
    @turn.start!
  end

  def action_call(actor, action)
    actor.method(action).call
  end
end

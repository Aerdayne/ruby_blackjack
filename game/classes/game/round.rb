# frozen_string_literal: true

class Round
  attr_accessor :table, :turn, :result
  def initialize(table)
    @table = table
    @turn = nil
    @result = []
    start
    finish
  end

  def start
    [@table.player, @table.dealer].each do |actor|
      actor.bet!
      2.times { actor.hit! }
    end
    next_turn(PlayerTurn, %i[flip stand hit!])
  end

  def finish
    @result << @table.player.flip.map(&:clone)
    @result << @table.dealer.flip.map(&:clone)
    [@table.player, @table.dealer].each { |actor| actor.hand.reshuffle! }
    @result
  end

  def next_turn(actor_turn, actions)
    @turn = actor_turn.new(self)
    @turn.start!(actions)
  end

  def action_call(actor, action)
    actor.method(action).call
  end
end

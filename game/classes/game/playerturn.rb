# frozen_string_literal: true

require_relative './turn.rb'
class PlayerTurn < Turn
  def initialize(round)
    @round = round
  end

  def start!(_actions)
    action = gets.chomp.to_sym
    result = @round.action_call(@round.table.player, action)
    return if result.length == 2

    @round.next_turn(DealerTurn, %i[stand hit!])
  end
end

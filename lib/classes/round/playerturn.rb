# frozen_string_literal: true

# :nodoc:
class PlayerTurn
  def initialize(round)
    @round = round
    @actor = @round.table.player
  end

  def start!
    @action = @round.table.game.round_interface.action_choice(@round.table.game.round_interface.actions)
    @round.action_call(@actor, @action)
  rescue CustomException => e
    puts e.message
    retry
  end
end

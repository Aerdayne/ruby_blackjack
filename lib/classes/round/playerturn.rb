# frozen_string_literal: true

# Player-specific turn logic class
#   @round - Round parent object
#   @actor - Player object
class PlayerTurn
  def initialize(round)
    @round = round
    @actor = @round.table.player
  end

  # Sends a callback to RoundInterface, gets a user
  # chosen action in return.
  def start!
    @action = @round.table.game.round_interface.action_choice(@round.table.game.round_interface.actions)
    @round.action_call(@actor, @action)
  rescue CustomException => e
    puts e.message
    retry
  end
end

# frozen_string_literal: true

# Dealer-specific turn logic class
#   @round - Round parent object
#   @actor - Player object
class DealerTurn
  def initialize(round)
    @round = round
    @actor = @round.table.dealer
  end

  # Determines the most viable option and calls the chosen action.
  def start!
    @action = @round.table.dealer.hand.calculate_value! > 16 ? :stand : :hit!
    @action = :stand if @round.table.dealer.hand.cards.length == 3
    @round.action_call(@actor, @action)
  end
end

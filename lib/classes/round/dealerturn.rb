# frozen_string_literal: true

# :nodoc:
class DealerTurn
  def initialize(round)
    @round = round
    @actor = @round.table.dealer
  end

  def start!
    @action = @round.table.dealer.hand.calculate_value! > 16 ? :stand : :hit!
    @action = :stand if @round.table.dealer.hand.cards.length == 3
    @round.action_call(@actor, @action)
  end
end

# frozen_string_literal: true

class DealerTurn < Turn
  def initialize(round)
    @round = round
  end

  def start!(*)
    action = if @round.table.dealer.hand.calculate_value! > 16
               :stand
             else
               :hit!
             end
    @round.action_call(@round.table.dealer, action)
    @round.next_turn(PlayerTurn, %i[flip stand])
  end
end

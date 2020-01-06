# frozen_string_literal: true

# Round logic class
#   @table  - Table parent object
#   @turn   - DealerTurn or PlayerTurn object
#   @result - Hash that contains player's and dealer's cards at the end of the round
class Round
  attr_accessor :table, :turn, :result

  def initialize(table)
    @table = table
    @turn = nil
    @result = { player: [], dealer: [], winner: nil }
  end

  # Before a new round, all the cards in the deck are shuffled,
  # actors deposit their bets and draw two cards each.
  # Returns the cards player has in hand.
  def start
    @table.deck.shuffle!
    [@table.player, @table.dealer].each do |actor|
      actor.bet!
      2.times { actor.hit! }
    end
    @table.player.hand.cards
  end

  # When the round is finished, both players flip their cards,
  # the remaining cards in hand return to the deck.
  # Returns the @result hash that contains both players' cards.
  def finish
    @result[:player] = @table.player.hand.flip.map(&:clone)
    @result[:dealer] = @table.dealer.hand.flip.map(&:clone)
    [@table.player, @table.dealer].each { |actor| actor.hand.reshuffle! }
    @result
  end

  # Invokes either DealerTurn#start! or PlayerTurn#start! depending on
  # the passed parameter from RoundInterface instance.
  def next_turn(actor_turn)
    @turn = actor_turn.new(self)
    @turn.start!
  end

  # Calls the specified Player class method
  def action_call(actor, action)
    actor.method(action).call
  end
end

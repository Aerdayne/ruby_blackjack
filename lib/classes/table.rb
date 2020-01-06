# frozen_string_literal: true

# Main facade class that houses all other entities
#   @game   - Game parent object
#   @deck   - Deck object
#   @player - Player object
#   @dealer - Player object
#   @bank   - Bank object
#   @round  - Round object
class Table
  attr_accessor :deck, :player, :dealer, :bank, :game, :round

  def initialize(game)
    @game = game
    @deck = Deck.new
    @player = Player.new(self)
    @dealer = Player.new(self)
    @bank = Bank.new(@player, @dealer)
    @round = nil
  end

  def start_round
    raise DrainedException if @deck.cards.empty?

    @round = Round.new(self)
    @round.start
  end

  def finish_round
    @round.finish
  end

  # User interface endpoint, gets passed either PlayerTurn or DealerTurn class
  # from RoundInterface instance.
  def round_action(turn_class)
    @round.next_turn(turn_class)
  end

  # Calculates the round outcome and determines the winner.
  # Returns an altered @round.result hash.
  def round_result
    pscore = 21 - @round.result[:player][1]
    dscore = 21 - @round.result[:dealer][1]
    if pscore.negative? && dscore.negative? || pscore == dscore
      winner = nil
    elsif pscore.negative?
      winner = @dealer
    elsif dscore.negative?
      winner = @player
    elsif pscore > dscore
      winner = @dealer
    elsif dscore > pscore
      winner = @player
    end
    @bank.dispense_bets(winner)
    @round.result[:winner] = if winner == @player
                               'Player'
                             elsif winner == @dealer
                               'Dealer'
                             else
                               'Nobody'
                             end
    @round.result
  end
end

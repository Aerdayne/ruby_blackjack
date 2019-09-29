# frozen_string_literal: true

# :nodoc:
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
    if winner == @player
      @round.result[:winner] = 'Player'
    elsif winner == @dealer
      @round.result[:winner] = 'Dealer'
    else
      @round.result[:winner] = 'Nobody'
    end
    @round.result
  end
end

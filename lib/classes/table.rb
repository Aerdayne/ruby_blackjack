# frozen_string_literal: true

# :nodoc:
class Table
  attr_accessor :deck, :player, :dealer, :bank, :game, :round

  def initialize(game)
    @game = game
    @deck = Deck.new
    @player = Player.new(self)
    @dealer = Player.new(self)
    @bank = 0
    @round = nil
  end

  def start_round
    @round = Round.new(self)
    @round.start
  end

  def round_result
    pscore = 21 - @round.result[:player][1]
    dscore = 21 - @round.result[:dealer][1]
    if pscore.negative? && dscore.negative? || pscore == dscore
      @player.bank += 10
      @dealer.bank += 10
      winner = 'A tie'
    elsif pscore.negative?
      @dealer.bank += @bank
      winner = 'Dealer wins'
    elsif dscore.negative?
      @player.bank += @bank
      winner = 'Player wins'
    elsif pscore > dscore
      @dealer.bank += @bank
      winner = 'Dealer wins'
    elsif dscore > pscore
      @player.bank += @bank
      winner = 'Player wins'
    end
    @bank = 0
    @round.result[:winner] = winner
    @round.result
  end
end

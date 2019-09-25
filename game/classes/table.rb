# frozen_string_literal: true

class Table
  attr_accessor :deck, :player, :dealer, :bank, :game, :round
  def initialize(game)
    self.game = game
    self.deck = Deck.new
    self.player = Player.new(self)
    self.dealer = Player.new(self)
    self.bank = 0
  end

  def start_round
    @deck.shuffle!
    self.round = Round.new(self)
    round_result
  end

  def round_result
    if round.result[0][1] > round.result[1][1]
      player.bank += bank
      self.bank = 0
    else
      dealer.bank += bank
      self.bank = 0
    end
    print round.result
  end
end

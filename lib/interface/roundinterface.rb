# frozen_string_literal: true

# :nodoc
class RoundInterface < Game
  attr_accessor :actions
  def initialize(game)
    @game = game
    @actions = { 1 => ['Stand', :stand],
                 2 => ['Hit a card', :hit!],
                 3 => ['Flip cards', :flip] }
  end

  def start_round
    @result = new_round
    @result.slice(:player, :dealer).each do |actor, outcome|
      puts "\n#{actor.to_s.capitalize}'s hand:"
      outcome[0].each do |card|
        puts "  #{card.rank.to_s.capitalize} of #{card.suit.to_s.capitalize}"
      end
      puts "Total value: #{outcome[1]}"
    end
    puts "#{@result[:winner]} wins!"
  end

  def new_round
    @player_cards = @game.table.start_round
    @game.display_bank
    puts "\nYour hand:"
    @player_cards.each do |card|
      puts "#{card.rank.to_s.capitalize} of #{card.suit.to_s.capitalize}"
    end
    until @game.table.player.hand.flipped?
      action = @game.table.round.next_turn(PlayerTurn)
      puts "Player #{action}s"
      break if action == :flip

      action = @game.table.round.next_turn(DealerTurn)
      puts "Dealer #{action}s"
      puts "\nYour hand:"
        @player_cards.each do |card|
          puts "#{card.rank.to_s.capitalize} of #{card.suit.to_s.capitalize}"
      end
    end
    @game.table.round.finish
    @game.table.round_result
  end
end

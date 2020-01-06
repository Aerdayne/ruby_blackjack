# frozen_string_literal: true

# Interface class responsible for user interaction during rounds
#   @game     - Game parent object
#   @actions  - Hash that maps action numbers to respective class methods
class RoundInterface < Game
  attr_accessor :actions
  def initialize(game)
    @game = game
    @actions = { 1 => ['Stand', :stand],
                 2 => ['Hit a card', :hit!],
                 3 => ['Flip cards', :flip] }
  end

  # Starts the main user interaction loop during the round and outputs the round result
  def start_round
    @result = round_loop
    @result.slice(:player, :dealer).each do |actor, outcome|
      puts "\n#{actor.to_s.capitalize}'s hand:"
      outcome[0].each do |card|
        puts "  #{card.rank.to_s.capitalize} of #{card.suit.to_s.capitalize}"
      end
      puts "Total value: #{outcome[1]}"
    end
    puts "#{@result[:winner]} wins!"
  end

  # Main user interaction loop during the round, serves as a
  # major app logic endpoint. Player action is obtained from a callback.
  # Returns a hash that contains the round outcome.
  def round_loop
    @player_cards = @game.table.start_round
    @game.display_bank
    show_hand
    until @game.table.player.hand.flipped?
      action = @game.table.round_action(PlayerTurn)
      puts "Player #{action}s"
      break if action == :flip

      action = @game.table.round_action(DealerTurn)
      puts "Dealer #{action}s"
      show_hand
    end
    @game.table.finish_round
    @game.table.round_result
  end

  private

  def show_hand
    puts "\nYour hand:"
    @player_cards.each do |card|
      puts "#{card.rank.to_s.capitalize} of #{card.suit.to_s.capitalize}"
    end
  end
end

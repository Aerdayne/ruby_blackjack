# frozen_string_literal: true

# :nodoc:
class Game
  attr_accessor :calls, :outputs, :table, :round_interface
  def initialize
    @table = Table.new(self)
    @round_interface = RoundInterface.new(self)
    @actions = { 1 => ['Start a round', method(:start_round)],
                 2 => ['Display bank', method(:display_bank)],
                 3 => ['Exit', :exit] }
  end

  def start
    loop do
      action = action_choice(@actions)
      break if action == :exit

      action.call
    end
  end

  def action_choice(actions)
    puts "\nChoose an action:"
    actions.each do |key, value|
      puts "#{key.to_i} - #{value[0]}"
    end
    input = gets.chomp

    raise CustomException, 'Invalid action!' unless input.to_i.between?(1, actions.length)

    @actions[input.to_i][1]
  rescue CustomException => e
    puts e.message
    retry
  end

  def display_bank
    puts "Your bank: #{@table.player.bank}\nDealers bank: #{@table.dealer.bank}\nBet: #{@table.bank}\n"
  end

  def start_round
    @round_interface.start_round
  end
end

# frozen_string_literal: true

# The main interface class
#   @table           - Table object
#   @round_interface - RoundInterface object
#   @actions         - Hash that maps action numbers to respective class methods
class Game
  attr_accessor :table, :round_interface

  def initialize
    @table = Table.new(self)
    @round_interface = RoundInterface.new(self)
    @actions = { 1 => ['Start a round', method(:start_round)],
                 2 => ['Display bank', method(:display_bank)],
                 3 => ['Exit', :exit] }
  end

  # Main user interaction loop
  def start
    loop do
      action = action_choice(@actions)
      break if action == :exit

      action.call
    end
  rescue DrainedException, BankException => e
    puts e.message
    retry
  end

  # Invoked when an action from the user is required.
  # Returns a respective method name extracted from @actions
  def action_choice(actions)
    puts "\nChoose an action:"
    actions.each do |key, value|
      puts "#{key.to_i} - #{value[0]}"
    end
    input = gets.chomp

    unless input.to_i.between?(1, actions.length)
      raise CustomException, 'Invalid action!'
    end

    @actions[input.to_i][1]
  rescue CustomException => e
    puts e.message
    retry
  end

  protected

  def display_bank
    puts "Your bank: #{@table.bank.balance(@table.player)}\nDealers bank: #{@table.bank.balance(@table.dealer)}\nBet: #{@table.bank.balance}\n"
  end

  def start_round
    @round_interface.start_round
  end
end

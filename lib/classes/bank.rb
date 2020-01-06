# frozen_string_literal: true

# :nodoc:
class Bank
  attr_accessor :player_balance, :dealer_balance

  BET = 10

  def initialize(player, dealer)
    unless [player, dealer].all?(Player)
      raise CustomException, 'Wrong argument type'
    end

    @player_balance = Balance.new(100)
    @dealer_balance = Balance.new(100)
    @balance = Balance.new
    @accounts = { player => @player_balance, dealer => @dealer_balance, table: @balance }
  end

  def balance(owner = :table)
    @accounts[owner].balance
  end

  def accept_bet(player, sum)
    @accounts[player].withdraw!(sum)
    @balance.deposit!(BET)
  end

  def dispense_bets(winner = nil)
    if winner.nil?
      @accounts.reject { |k| k == :table }.each_value do |balance|
        balance.deposit!(BET)
      end
    else
      @accounts[winner].deposit!(@balance.balance)
    end
    @balance.withdraw!
  end
end

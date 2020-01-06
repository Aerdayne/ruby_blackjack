# frozen_string_literal: true

class Balance
  attr_accessor :balance

  def initialize(sum = 0)
    @balance = sum
  end

  def deposit!(sum)
    @balance += sum
  end

  def withdraw!(sum = @balance)
    raise BankException if @balance.zero?

    @balance -= sum
  end
end

# frozen_string_literal: true

require_relative '../main.rb'
require 'test/unit'

class AutoTest < Test::Unit::TestCase
  # Tests the scenario in which a player draws 2 randm cards
  def test_value_two_in_hand
    50.times do
      t = Table.new 123
      t.deck.shuffle!
      2.times { t.player.hand.draw! }
      assert_includes 4..21, t.player.hand.calculate_value!
    end
  end

  # Tests the scenario in which a player draws 3 random cards
  def test_value_three_in_hand
    50.times do
      t = Table.new 123
      t.deck.shuffle!
      3.times { t.player.hand.draw! }
      assert_includes 6..30, t.player.hand.calculate_value!
    end
  end

  # Tests the scenario in which a player draws 1 non-ace card and 1 ace,
  # then draws 1 more non-ace card
  def test_value_soft_hand
    50.times do
      t = Table.new 123
      t.deck.shuffle!
      t.player.hand.cards << t.deck.cards.delete(t.deck.cards.reject(&:ace?).pop)
      t.player.hand.cards << t.deck.cards.delete(t.deck.cards.select(&:ace?).pop)
      assert_includes 13..21, t.player.hand.calculate_value!
      t.player.hand.cards << t.deck.cards.delete(t.deck.cards.reject(&:ace?).pop)
      assert_includes 11..21, t.player.hand.calculate_value!
    end
  end
end

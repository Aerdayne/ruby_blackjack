# frozen_string_literal: true

require_relative './lib/classes/card.rb'
require_relative './lib/classes/deck.rb'
require_relative './lib/classes/hand.rb'
require_relative './lib/classes/player.rb'
require_relative './lib/classes/table.rb'

require_relative './lib/classes/round/round.rb'
require_relative './lib/classes/round/playerturn.rb'
require_relative './lib/classes/round/dealerturn.rb'

require_relative './lib/exceptions/customexception.rb'
require_relative './lib/exceptions/drainedexception.rb'
require_relative './lib/exceptions/bankexception.rb'
require_relative './lib/exceptions/handexception.rb'

require_relative './lib/interface/game.rb'
require_relative './lib/interface/roundinterface.rb'

game = Game.new
game.start

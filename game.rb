require_relative './controllers/game_controller'
require_relative './models/dealer'
require_relative './models/gamer'
require_relative './models/deck'

controller = GameController.new
controller.name

loop do
  controller.show_cards
  controller.show_action
  controller.select_action
end

# frozen_string_literal: true

require_relative './controllers/game_controller'
require_relative './models/dealer'
require_relative './models/gamer'
require_relative './models/deck'

def start
  @controller = GameController.new
  @controller.name
end

start
loop do
  @controller.start
  @controller.show_cards
  @controller.to_bet
  @controller.show_bank
  @controller.show_moves
  @controller.gamer_choice
  @controller.scoring
  @controller.game_score
  @controller.match_score
  if !@controller.game_over?
    @controller.new_game?
  elsif @controller.game_over?
    start if @controller.new_match?
  end
end

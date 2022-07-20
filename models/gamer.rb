# frozen_string_literal: true

class Gamer
  attr_reader :name, :cards_in_hands, :cash_account, :cards_out_hands, :wins

  def initialize(name)
    @name = name
    @cash_account = 100
    @cards_in_hands = {}
    @wins = 0
  end

  def take_card(deck)
    card = deck.card
    @cards_in_hands[card.first] = card.last
  end

  def to_pass; end

  def open_cards
    @cards_in_hands.each_key do |card|
      print "|#{card}| "
    end
  end

  def score
    @cards_in_hands.val
  end

  def fold_cards
    @cards_in_hands.clear
  end
end

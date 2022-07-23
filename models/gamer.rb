# frozen_string_literal: true

class Gamer
  attr_reader :name, :cards_in_hands, :cards_out_hands
  attr_accessor :wins, :cash_account

  def initialize(name)
    @name = name
    @cash_account = 10
    @cards_in_hands = {}
    @wins = 0
    @points = 0
  end

  def take_card(deck)
    card = deck.card
    @cards_in_hands[card.first] = card.last
  end

  def to_pass; end

  def open_cards
    cards = []
    @cards_in_hands.each_key do |card|
      cards << "|#{card}|"
    end
    cards.join
  end

  def points
    points_without_ace = @cards_in_hands.reject { |card, _points| card.include? 'A' }
    @points = points_without_ace.values.sum
    @points += if @cards_in_hands.values.include?(11) && @points > 10
                 1
               elsif @cards_in_hands.values.include?(11) && @points <= 10
                 11
               else
                 0
               end
    @points
  end

  def bust?
    @points > 21
  end

  def fold_cards
    @cards_in_hands.clear
    @points = 0
  end
end

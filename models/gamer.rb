class Gamer
  attr_reader :name, :cards_in_hands

  def initialize(name, desk)
    @name = name
    @cash_account = 100
    @cards_in_hands = desk.set_of_cards
    @cards_out_hands = nil
  end

  def take_card(deck)
    @cards_in_hands << deck.card
  end

  def to_pass
    nil
  end

  def open_cards
    @cards_out_hands.concat(cards_in_hands)
    @cards_in_hands
    @cards_in_hands.clear
  end
end

class Deck
  CARDS = [*(2..10), 'J', 'Q', 'K', 'A'].freeze
  SUITS = ['♥', '♦', '♣', '♠'].freeze

  attr_reader :deck

  def initialize
    @deck = {}
    complete_deck
  end

  def complete_deck
    CARDS.each do |card|
      SUITS.each do |suit|
        @deck[card.to_s + suit] = if %w[J Q K].include?(card)
                                    10
                                  elsif card == 'A'
                                    [1, 11]
                                  else
                                    card
                                  end
      end
    end
  end

  def starter_set(gamer)
    2.times do |_i|
      card_arr = card
      gamer.cards_in_hands[card_arr.first] = card_arr.last
    end
  end

  def card
    card = @deck.keys.sample
    score = @deck.values_at(card)
    @deck.delete(card)
    [card, score]
  end
end
